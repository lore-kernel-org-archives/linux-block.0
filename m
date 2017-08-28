Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25744 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdH1StM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2017 14:49:12 -0400
Date: Mon, 28 Aug 2017 21:49:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: shli@fb.com
Cc: linux-block@vger.kernel.org
Subject: [bug report] nullb: add interface to power on disk
Message-ID: <20170828184901.ehaflki7emvhrb6a@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Shaohua Li,

The patch cedcafad8277: "nullb: add interface to power on disk" from
Aug 14, 2017, leads to the following static checker warning:

	drivers/block/null_blk.c:372 nullb_device_power_store()
	warn: 'dev' was already freed.

	drivers/block/null_blk.c:1993 null_init()
	error: double free of 'dev'

drivers/block/null_blk.c
   356  
   357  static ssize_t nullb_device_power_store(struct config_item *item,
   358                                       const char *page, size_t count)
   359  {
   360          struct nullb_device *dev = to_nullb_device(item);
   361          bool newp = false;
   362          ssize_t ret;
   363  
   364          ret = nullb_device_bool_attr_store(&newp, page, count);
   365          if (ret < 0)
   366                  return ret;
   367  
   368          if (!dev->power && newp) {
   369                  if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
   370                          return count;
   371                  if (null_add_dev(dev)) {
                            ^^^^^^^^^^^^^^^^^
null_add_dev() frees dev on failure
   372                          clear_bit(NULLB_DEV_FL_UP, &dev->flags);
                                                            ^^^^^^^^^^
so this is a use after free.  The other time null_add_dev() is called
is buggy as well.  I feel like it shouldn't be freeing "dev" because
that's a layering violation.

   373                          return -ENOMEM;
   374                  }
   375  
   376                  set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
   377                  dev->power = newp;
   378          } else if (to_nullb_device(item)->power && !newp) {
   379                  mutex_lock(&lock);
   380                  dev->power = newp;
   381                  null_del_dev(dev->nullb);
   382                  mutex_unlock(&lock);
   383                  clear_bit(NULLB_DEV_FL_UP, &dev->flags);
   384          }
   385  
   386          return count;
   387  }

regards,
dan carpenter
