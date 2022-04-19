Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84E7C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 04:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiDSE0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSE0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 00:26:09 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F020F61
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 21:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650342206; x=1681878206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h2sKctrxRnb5Wul/X1SYvQAAuX2xq2d93wu8H86cs4w=;
  b=E6ufseDCrm1tiD6B7K5K3TkIgwdYCYge/EOE5xvQ0+H+u8R2QfW21TCs
   kKh2s1w7+Gyw4Bg/qvLMQN+9c58StX3R+ncY/OHHkpqldsBwPe1i8e5m0
   5ziuAYkwtmfgIzdsrk4n3E7CuNG6mKLgzHv9SyHyHIyUhSYjkZwYFW19B
   mx6o/DQeIQo3J7J9Myfbskw4dCBOzrUtYU9ONQ3mB8ecdNhwrUcroMHaE
   CBmMZRAanA/0p2gVCzbOofAy0Cz9RaiNT6H2OqQ3ulUII/1x0dIUNHH9E
   7/IMvT2mLra/ngc0Nfb+hhIOdaWrwH0YCjdtu64IRWNqZl01zGd9JpZrw
   w==;
X-IronPort-AV: E=Sophos;i="5.90,271,1643644800"; 
   d="scan'208";a="197087163"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 12:23:25 +0800
IronPort-SDR: izdcClDewhXYz3kC1/Ae9d/074KPaX3JtFrkik60717buEysQumu9r8RMUbcT1t/X7J6T41SPu
 lFWCRPJLzdLK0ySNwQ01GinyIXhVD33hx8oc19Wp6+OUeqZAD1muAaIwGIoL4c4tUIVTo+QHYU
 8QCTWYl9LJGK/IH0Mz61VsFPiO42IDSnbXF09guGv8Zi4n80YKTkeAL6eWZyu15Z0khRGrVqKx
 GhmMa54i6B8i0EaUBpWZT44vPuBdn3KZuDQrBx5ORRDobHiLqenCPHmIiD7kjJi2xo7ZJtdEuC
 QHdUOx7hsC98OOYMc3sdNlge
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 20:54:31 -0700
IronPort-SDR: StfS2+hgwHLTSaZi5zPvQ0sPYFWyEf3lt5TdHGuUOKrUp5xVgpSu/I4mi1BN/us1TMEjm9BhGi
 cZTPfNBxR9t6hutoB17LUu5/1M7YKwwa4DtX1wX3xkbiFlrRNiIMTxPpSi+T5q27H8TxLfeCAj
 sor1AyHKK5LNWxiD4P3XmDUy4GtRZ1X07RZ/IqIR7tUlGV/a00QCn6WKA4vH2GSYokIZZbLnW5
 V+spC4+wSatToyA++L679KOyKA14cyAClkFVVzca5czwn1GuTr6yga7WSbnb0IwccoB3pyjE78
 X64=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 21:23:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kj9f50ctLz1Rwrw
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 21:23:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650342204; x=1652934205; bh=h2sKctrxRnb5Wul/X1SYvQAAuX2xq2d93wu
        8H86cs4w=; b=HGeJ7hkp+9mEZk+J33cwAeSCjp6mkJ2GT8hnrn8mtISM9ySHz0V
        GSn/pwYF43jQAnswEFlyOaCsT5WPh4LKCRN37mB5pRorTRWt3WA+T3PCYaX8yftP
        fVm28ZnsIqrlVVFvCvd74xmYH39CmJH6Ikc4p8d27mCM8v08THcgt4yzzF8d/wz6
        bWongLwq+vylCReAnBb7djNAhWw3cFVezoOShI034tYiRb35v3f0zQHvia9AAmb2
        Rg1Xb+9IqN5GhQYnLblEUbTJDGO/tyewUxvk1yiGIOAm+gyukX6wBYOIRcIWUXLO
        BNsYpd8gSp3rAsFXTH5pm+eULHK7LV4ighg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g2Q9Ste6tMGB for <linux-block@vger.kernel.org>;
        Mon, 18 Apr 2022 21:23:24 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kj9f32szlz1Rvlx;
        Mon, 18 Apr 2022 21:23:23 -0700 (PDT)
Message-ID: <c5418ac1-460f-348f-d7a3-d7c3a1aaad71@opensource.wdc.com>
Date:   Tue, 19 Apr 2022 13:23:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Nullblk configfs oddities
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
 <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
 <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk>
 <827699fb-e21b-2cad-6a6d-0a21c49f444e@nvidia.com>
 <bc93d84b-3c10-07ed-5203-9eba485fb108@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bc93d84b-3c10-07ed-5203-9eba485fb108@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/22 07:24, Jens Axboe wrote:
> On 4/18/22 4:21 PM, Chaitanya Kulkarni wrote:
>> On 4/18/22 15:14, Jens Axboe wrote:
>>> On 4/18/22 3:54 PM, Chaitanya Kulkarni wrote:
>>>> On 4/18/22 14:38, Josef Bacik wrote:
>>>>> Hello,
>>>>>
>>>>> I'm trying to add a test to fsperf and it requires the use of nullblk.  I'm
>>>>> trying to use the configfs thing, and it's doing some odd things.  My basic
>>>>> reproducer is
>>>>>
>>>>> modprobe null_blk
>>>>> mkdir /sys/kernel/config/nullb/nullb0
>>>>> echo some shit into the config
>>>>> echo 1 > /sys/kernel/config/nullb/nullb0/power
>>>>>
>>>>> Now null_blk apparently defaults to nr_devices == 1, so it creates nullb0 on
>>>>> modprobe.  But this doesn't show up in the configfs directory.  There's no way
>>>>> to find this out until when I try to mkfs my nullb0 and it doesn't work.  The
>>>>> above steps gets my device created at /dev/nullb1, but there's no actual way to
>>>>> figure out that's what happened.  If I do something like
>>>>> /sys/kernel/config/nullb/nullbfsperf I still just get nullb<number>, I don't get
>>>>> my fancy name.
>>>>>
>>>>
>>>> when you load module with default module parameter it will create a
>>>> default device with no memory backed mode, that will not be visible in
>>>> the configfs.
>>>
>>> Right, the problem is really that pre-configured devices (via nr_devices
>>> being bigger than 0, which is the default) don't show up in configfs.
>>> That, to me, is the real issue here, because it means you need to know
>>> which ones are already setup before doing mkdir for a new one.
>>>
>>> On top of that, it's also odd that they don't show up there to begin
>>> with.
>>>
>>
>> it is indeed confusing, maybe we need to find a way to populate the
>> configfs when loading the module? but I'm not sure if that is
>> the right approach since configs ideally should be populated by
>> user.
>>
>> OTOH we can make the memory_backed module param [1] so user can
>> tentatively not use configfs and only rely on default configuration ?
> 
> Arguably configfs should just be disabled if loading with nr_devices
> larger than 0, as it's a mess of an API as it stands. But probably too
> late for that. The fact that we also have an option that's specific to
> configfs just makes it even worse.
> 
> I don't know much about configfs, but pre-populating with the configured
> devices and options would be ideal and completely solve this. I think
> that would be the best solution given the current situation. Not that
> it's THAT important, null_blk is a developer tool and as such can have
> some sharper and rouger edges. Still would be nice to make it saner,
> though.
> 

I came up with this. It does prepopulate configfs nullb directory with the
devices created on modprobe. But... doing an rmmod now always gives a
"rmmod: ERROR: Module null_blk is in use" because configfs takes a ref on
nullblk module for each entry. So the user now must do an rmdir of all
prepopulated devices before doing rmmod. Not ideal. And messing up with
the module references is probably not a good idea...


diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1aa4897685f6..98933555b59f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/namei.h>
 #include "null_blk.h"

 #define FREE_BATCH		16
@@ -667,6 +668,7 @@ static void null_free_dev(struct nullb_device *dev)

 	null_free_zoned_dev(dev);
 	badblocks_exit(&dev->badblocks);
+	kfree(dev->config_path);
 	kfree(dev);
 }

@@ -2088,12 +2090,121 @@ static int null_add_dev(struct nullb_device *dev)
 	return rv;
 }

+#ifdef CONFIG_CONFIGFS_FS
+
+static int nullb_create_dev(int idx)
+{
+	char disk_name[DISK_NAME_LEN];
+	struct nullb_device *dev;
+	struct config_item *item;
+	struct dentry *dentry;
+	struct path parent;
+	const char *path;
+	int ret;
+
+	/* Use configfs to allocate the device */
+	sprintf(disk_name, "nullb%d", idx);
+	path = kasprintf(GFP_KERNEL, "/sys/kernel/config/nullb/%s", disk_name);
+	if (!path)
+		return -ENOMEM;
+
+	dentry = kern_path_create(AT_FDCWD, path, &parent, LOOKUP_DIRECTORY);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto free;
+	}
+
+	ret = vfs_mkdir(mnt_user_ns(parent.mnt), d_inode(parent.dentry),
+			dentry, 0755);
+	if (ret)
+		goto done;
+
+	/* Start the device */
+	item = config_group_find_item(&nullb_subsys.su_group, disk_name);
+	if (!item) {
+		pr_err("Device %s not powered up\n", disk_name);
+		goto done;
+	}
+
+	dev = to_nullb_device(item);
+	set_bit(NULLB_DEV_FL_UP, &dev->flags);
+	ret = null_add_dev(dev);
+	if (ret) {
+		clear_bit(NULLB_DEV_FL_UP, &dev->flags);
+		goto put;
+	}
+
+	set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
+	dev->power = true;
+	dev->config_path = path;
+	path = NULL;
+
+put:
+	config_item_put(item);
+done:
+	done_path_create(&parent, dentry);
+free:
+	kfree(path);
+
+	return ret;
+}
+
+static void nullb_destroy_dev(struct nullb *nullb)
+{
+	struct nullb_device *dev = nullb->dev;
+	struct dentry *dentry;
+	struct path parent;
+
+	dentry = kern_path_create(AT_FDCWD, dev->config_path, &parent,
LOOKUP_DIRECTORY);
+	if (IS_ERR(dentry)) {
+		pr_err("Lookup %s failed %ld\n",
+		       dev->config_path, PTR_ERR(dentry));
+		return;
+	}
+
+	if (d_really_is_positive(dentry)) {
+		vfs_rmdir(mnt_user_ns(parent.mnt), d_inode(parent.dentry),
+			  dentry);
+		dput(dentry);
+	}
+
+	done_path_create(&parent, dentry);
+}
+
+#else
+
+static int nullb_create_dev(int idx)
+{
+	struct nullb_device *dev;
+
+	dev = null_alloc_dev();
+	if (!dev)
+		return -ENOMEM;
+
+	ret = null_add_dev(dev);
+	if (ret) {
+		null_free_dev(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int nullb_destroy_dev(struct nullb *nullb)
+{
+	struct nullb_device *dev = nullb->dev;
+
+	null_del_dev(nullb);
+	null_free_dev(dev);
+}
+
+#endif
+
 static int __init null_init(void)
 {
 	int ret = 0;
 	unsigned int i;
 	struct nullb *nullb;
-	struct nullb_device *dev;

 	if (g_bs > PAGE_SIZE) {
 		pr_warn("invalid block size\n");
@@ -2151,16 +2262,9 @@ static int __init null_init(void)
 	}

 	for (i = 0; i < nr_devices; i++) {
-		dev = null_alloc_dev();
-		if (!dev) {
-			ret = -ENOMEM;
-			goto err_dev;
-		}
-		ret = null_add_dev(dev);
-		if (ret) {
-			null_free_dev(dev);
+		ret = nullb_create_dev(i);
+		if (ret)
 			goto err_dev;
-		}
 	}

 	pr_info("module loaded\n");
@@ -2169,9 +2273,7 @@ static int __init null_init(void)
 err_dev:
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
-		dev = nullb->dev;
-		null_del_dev(nullb);
-		null_free_dev(dev);
+		nullb_destroy_dev(nullb);
 	}
 	unregister_blkdev(null_major, "nullb");
 err_conf:
diff --git a/drivers/block/null_blk/null_blk.h
b/drivers/block/null_blk/null_blk.h
index 78eb56b0ca55..ecdc22e74d35 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -61,6 +61,7 @@ struct nullb_zone {
 struct nullb_device {
 	struct nullb *nullb;
 	struct config_item item;
+	const char *config_path;
 	struct radix_tree_root data; /* data stored in the disk */
 	struct radix_tree_root cache; /* disk cache data */
 	unsigned long flags; /* device flags */



-- 
Damien Le Moal
Western Digital Research
