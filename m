Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F22C4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3142206C2
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="CIULcQ4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfIQSkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:40:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42639 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfIQSkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 14:40:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so5107782qkl.9
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kXRxt7l/Hnul9xFm/1KtEBFpTFqsvKvQGDG2GsitFVE=;
        b=CIULcQ4ujf8n7xzdDpo+oR1PYimJOzlDbJ6vPJI0RRfM0XF/wCAHZkHdH2Rulqucec
         s65hrmR9IMYaI03hPyQ6JaC1aXgIOTzW3Mj3/X+gKAY6H2Yh5MmpkTAoz5kTjCAkP4iV
         kqinEMEhCqbvxJc0hiONngpPXSBOZxV/0ZJ4qlBgbDrpoACR2suDyvOz8MFyEDCqfH9d
         xzm6Cl9WepwE3YJ2omvl3q9SwrGNTI1hsRgIDyBRFPhI1DCJDAWK2Mrl/XyIvaU7LC6O
         gtCMGsRD3ykg6xKvS5kCgN9VINt/TNdOX6aztApGHrE9budCGIGzEmeplkMkwt7rMrX8
         3Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXRxt7l/Hnul9xFm/1KtEBFpTFqsvKvQGDG2GsitFVE=;
        b=gQAnJ3OBPVSAeAzLNXawzpDjQXe2lEn8AEm6+WEid4rhKZaJNP9MrK48lcVm6sDdCM
         cj62Q+OE6OtTl8rcN3I8o35jen9R3imTYbcpoHtpR3hofJjYVD49Eai3qkXRjL93YDkB
         e2ej2eDH5mRS9cbFhF0jozJdNqpnQpOJahYrIvii+YcCtYEHJ7bNBxWefTWVk682AvXX
         jmP8oAZ9OzwN9jQDGYxdqFgPOHjOd0wIynsqEgI/5KhYqdDEmYDvqRg8f2zjwqvB4FYK
         RVizuaVsIzVVoGVwFLvYJh1vDYK6i18oEitFL7ewvFquYytQH3Vz19ttW2B6uEoY3DgJ
         qFqw==
X-Gm-Message-State: APjAAAUzTjyTSoAoiZnKY0vzQvybJGZUtG5m9qwNN9c3ceQWnuZCfM4S
        zPRXcC0Vzxoa4Co8huJr24xAyA==
X-Google-Smtp-Source: APXvYqwEwGTyPIF3HJPJE70f761k1LSFWKTxSFilOtANgn5hR6Ulb71rX/5fJepclGEINX6H0D2CfA==
X-Received: by 2002:a37:486:: with SMTP id 128mr5404382qke.141.1568745614572;
        Tue, 17 Sep 2019 11:40:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e7sm1600734qtb.94.2019.09.17.11.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:40:13 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:40:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     xiubli@redhat.com, josef@toxicpanda.com, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 2/2] nbd: fix possible page fault for nbd disk
Message-ID: <20190917184011.74ityetkw7n3sqbs@MacBook-Pro-91.local>
References: <20190917115606.13992-1-xiubli@redhat.com>
 <20190917115606.13992-3-xiubli@redhat.com>
 <5D812669.9050901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D812669.9050901@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 17, 2019 at 01:31:05PM -0500, Mike Christie wrote:
> On 09/17/2019 06:56 AM, xiubli@redhat.com wrote:
> > From: Xiubo Li <xiubli@redhat.com>
> > 
> > When the NBD_CFLAG_DESTROY_ON_DISCONNECT flag is set and at the same
> > time when the socket is closed due to the server daemon is restarted,
> > just before the last DISCONNET is totally done if we start a new connection
> > by using the old nbd_index, there will be crashing randomly, like:
> > 
> > <3>[  110.151949] block nbd1: Receive control failed (result -32)
> > <1>[  110.152024] BUG: unable to handle page fault for address: 0000058000000840
> > <1>[  110.152063] #PF: supervisor read access in kernel mode
> > <1>[  110.152083] #PF: error_code(0x0000) - not-present page
> > <6>[  110.152094] PGD 0 P4D 0
> > <4>[  110.152106] Oops: 0000 [#1] SMP PTI
> > <4>[  110.152120] CPU: 0 PID: 6698 Comm: kworker/u5:1 Kdump: loaded Not tainted 5.3.0-rc4+ #2
> > <4>[  110.152136] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> > <4>[  110.152166] Workqueue: knbd-recv recv_work [nbd]
> > <4>[  110.152187] RIP: 0010:__dev_printk+0xd/0x67
> > <4>[  110.152206] Code: 10 e8 c5 fd ff ff 48 8b 4c 24 18 65 48 33 0c 25 28 00 [...]
> > <4>[  110.152244] RSP: 0018:ffffa41581f13d18 EFLAGS: 00010206
> > <4>[  110.152256] RAX: ffffa41581f13d30 RBX: ffff96dd7374e900 RCX: 0000000000000000
> > <4>[  110.152271] RDX: ffffa41581f13d20 RSI: 00000580000007f0 RDI: ffffffff970ec24f
> > <4>[  110.152285] RBP: ffffa41581f13d80 R08: ffff96dd7fc17908 R09: 0000000000002e56
> > <4>[  110.152299] R10: ffffffff970ec24f R11: 0000000000000003 R12: ffff96dd7374e900
> > <4>[  110.152313] R13: 0000000000000000 R14: ffff96dd7374e9d8 R15: ffff96dd6e3b02c8
> > <4>[  110.152329] FS:  0000000000000000(0000) GS:ffff96dd7fc00000(0000) knlGS:0000000000000000
> > <4>[  110.152362] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[  110.152383] CR2: 0000058000000840 CR3: 0000000067cc6002 CR4: 00000000001606f0
> > <4>[  110.152401] Call Trace:
> > <4>[  110.152422]  _dev_err+0x6c/0x83
> > <4>[  110.152435]  nbd_read_stat.cold+0xda/0x578 [nbd]
> > <4>[  110.152448]  ? __switch_to_asm+0x34/0x70
> > <4>[  110.152468]  ? __switch_to_asm+0x40/0x70
> > <4>[  110.152478]  ? __switch_to_asm+0x34/0x70
> > <4>[  110.152491]  ? __switch_to_asm+0x40/0x70
> > <4>[  110.152501]  ? __switch_to_asm+0x34/0x70
> > <4>[  110.152511]  ? __switch_to_asm+0x40/0x70
> > <4>[  110.152522]  ? __switch_to_asm+0x34/0x70
> > <4>[  110.152533]  recv_work+0x35/0x9e [nbd]
> > <4>[  110.152547]  process_one_work+0x19d/0x340
> > <4>[  110.152558]  worker_thread+0x50/0x3b0
> > <4>[  110.152568]  kthread+0xfb/0x130
> > <4>[  110.152577]  ? process_one_work+0x340/0x340
> > <4>[  110.152609]  ? kthread_park+0x80/0x80
> > <4>[  110.152637]  ret_from_fork+0x35/0x40
> > 
> > This is very easy to reproduce by running the nbd-runner.
> > 
> > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > ---
> >  drivers/block/nbd.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 7e0501c47153..ac07e8c94c79 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/ioctl.h>
> >  #include <linux/mutex.h>
> >  #include <linux/compiler.h>
> > +#include <linux/completion.h>
> >  #include <linux/err.h>
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> > @@ -80,6 +81,9 @@ struct link_dead_args {
> >  #define NBD_RT_DESTROY_ON_DISCONNECT	6
> >  #define NBD_RT_DISCONNECT_ON_CLOSE	7
> >  
> > +#define NBD_DESTROY_ON_DISCONNECT	0
> > +#define NBD_DISCONNECT_REQUESTED	1
> > +
> >  struct nbd_config {
> >  	u32 flags;
> >  	unsigned long runtime_flags;
> > @@ -113,6 +117,9 @@ struct nbd_device {
> >  	struct list_head list;
> >  	struct task_struct *task_recv;
> >  	struct task_struct *task_setup;
> > +
> > +	struct completion *destroy_complete;
> > +	unsigned long flags;
> >  };
> >  
> >  #define NBD_CMD_REQUEUED	1
> > @@ -223,6 +230,16 @@ static void nbd_dev_remove(struct nbd_device *nbd)
> >  		disk->private_data = NULL;
> >  		put_disk(disk);
> >  	}
> > +
> > +	/*
> > +	 * Place this in the last just before the nbd is freed to
> > +	 * make sure that the disk and the related kobject are also
> > +	 * totally removed to avoid duplicate creation of the same
> > +	 * one.
> > +	 */
> > +	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) && nbd->destroy_complete)
> > +		complete(nbd->destroy_complete);
> > +
> >  	kfree(nbd);
> >  }
> >  
> > @@ -1125,6 +1142,7 @@ static int nbd_disconnect(struct nbd_device *nbd)
> >  
> >  	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
> >  	set_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
> > +	set_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags);
> >  	send_disconnects(nbd);
> >  	return 0;
> >  }
> > @@ -1636,6 +1654,7 @@ static int nbd_dev_add(int index)
> >  	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
> >  		BLK_MQ_F_BLOCKING;
> >  	nbd->tag_set.driver_data = nbd;
> > +	nbd->destroy_complete = NULL;
> >  
> >  	err = blk_mq_alloc_tag_set(&nbd->tag_set);
> >  	if (err)
> > @@ -1750,6 +1769,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
> >  
> >  static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
> >  {
> > +	DECLARE_COMPLETION_ONSTACK(destroy_complete);
> >  	struct nbd_device *nbd = NULL;
> >  	struct nbd_config *config;
> >  	int index = -1;
> > @@ -1801,6 +1821,17 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
> >  		mutex_unlock(&nbd_index_mutex);
> >  		return -EINVAL;
> >  	}
> > +
> > +	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
> > +	    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
> 
> You still need the nbd_put mutex part of the v3 patch don't you?
> 
> nbd_dev_remove could call kfree(nbd) while we are accessing the nbd
> device struct above.
> 

We're still holding the mutex here, so this is safe right?

> > +		nbd->destroy_complete = &destroy_complete;
> 
> Also, without the mutex part of the v3 patch, we could race and
> nbd_dev_remove could have passed the destroy_complete check already, so
> below we will wait forever.
> 

Oh hmm you're right, we need to re-init the completion every time.  I retract my
reviewed-by I guess.  Thanks,

Josef
