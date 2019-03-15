Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF21C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE8C20645
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hL656qSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfCOQdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:33:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40348 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfCOQdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:33:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id y124so6703765pfy.7
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bKyIVy1plr4oc5/xxGl3eETtPxJmReBFTCiX8YojzK4=;
        b=hL656qSFfacJ1mvjVLBsaeu3bO8GVksUbNtBAac6O1bTYzfqn26Z8XxfKtC92uMutX
         2EpUg9ks3a1srzQuZEfzE7VS8vwc1bxQjILlhTI8K7FA6FVNpQeAwmS+/9lCASoyExe8
         YC2cM7+QbGyp+DbJoHdnovUlD6x0g+RfRoXg7gsityS2AM6lKJasdQgWPizUqMUp/Rum
         k20I+67YD6t1yXu5zQngK/4PLxjAngUEjO/MkIZFZ+D5YKsAfk3st691Dg//fk8RV76K
         ry3neAuWL3DmcgezbB9RRycywIovLuOzweEm6DPu2tebikzjGpNRs1hF/bX/DqJYATeS
         JWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bKyIVy1plr4oc5/xxGl3eETtPxJmReBFTCiX8YojzK4=;
        b=pdv6P9juQ/Q8zpDVl29fqe5lEy9t25P6EUb2LWSlmueoOEFva4hF8hzr9wl8s83oNW
         2H/Zd9FPHl1KNC1PWqOkI886kj/mrvgiu0rQg2YXu+UoiCajgzUK30cr6jprwN0kAk+I
         92F6yStPYb79ejSK0Y0urZhYmbHa+PKKe4KhcPaJqA9PO3SxoAm/Vy/YMjqZ1L55YRJO
         /cRJiywqpsn1d4m8lShH3iOMSSpLVl1fiBUcLCOyMvgbz1gflLv6ELlyG9IhqTwJW4Wg
         IwoK9vj59/GcRPIaqYrW8l5JKNY6ZgyGWEuBmC4W8IIDUKyxpLHUvxhe2cDL+aSA0X8m
         gUNw==
X-Gm-Message-State: APjAAAW2myhvuOy4piwUXivfjtoUOMA2zznCrTZrQfgamAC1n7rZOnqS
        YOKbg6NTfEL1jrHIQp2E2jd5Uw==
X-Google-Smtp-Source: APXvYqx9PQ+5f2rVcMkiVwN/6IZWa5CMZ1bvMgqGAJuZ99j5TTxX9RSkUTI+XLdd4TB+vNfdyQpXGw==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr5065636plt.195.1552667599501;
        Fri, 15 Mar 2019 09:33:19 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q4sm1773070pgp.36.2019.03.15.09.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:33:18 -0700 (PDT)
Subject: Re: paride/pf.c: blk-mq use-after-free (kernel v5.0)
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org
References: <30c63b2d-92d2-51be-40f0-62cada110388@infradead.org>
 <7d24a06f-f219-e50a-e8f8-915a6cc1b796@infradead.org>
 <e2a66da2-5433-5b42-1ebe-9f1c135b5471@infradead.org>
 <59cb035e-6880-de5a-33c5-d4db6ed910f4@kernel.dk>
 <4a2adc33-ef38-6a5f-65ee-8fcfaa0948a9@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d22bf156-06df-ec67-121d-7dce65088b1a@kernel.dk>
Date:   Fri, 15 Mar 2019 10:33:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4a2adc33-ef38-6a5f-65ee-8fcfaa0948a9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 5:49 PM, Randy Dunlap wrote:
> On 3/14/19 4:43 PM, Jens Axboe wrote:
>> On 3/13/19 5:09 PM, Randy Dunlap wrote:
>>> On 3/11/19 6:34 PM, Randy Dunlap wrote:
>>>> On 3/11/19 6:25 PM, Randy Dunlap wrote:
>>>>> [Has this already been addressed/fixed?]>>
>>>>
>>>> Same bug occurs with paride/pcd.c driver.
>>>
>>> This still happens (in blk-mq) in v5.0-11053-gebc551f2b8f9 of Mar. 12, 2019,
>>> around 4pm PT.  [caused by paride: pf.c and pcd.c)
>>
>> I'll take a look at this, been busy with other stuff. How are you
>> reproducing this? I'm assuming you don't actually have any hardware :-)
> 
> Right.  I just load the module (pf or pcd), unload it, and
> then load it again.

Does this work?


diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 96670eefaeb2..4681ddef5666 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -749,8 +749,11 @@ static int pcd_detect(void)
 		return 0;
 
 	printk("%s: No CD-ROM drive found\n", name);
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
+	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
+		blk_cleanup_queue(cd->disk->queue);
+		blk_mq_free_tag_set(&cd->tag_set);
 		put_disk(cd->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index e92e7a8eeeb2..d27f375bb55a 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -761,8 +761,11 @@ static int pf_detect(void)
 		return 0;
 
 	printk("%s: No ATAPI disk detected\n", name);
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
+	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
+		blk_cleanup_queue(pf->disk->queue);
+		blk_mq_free_tag_set(&pf->tag_set);
 		put_disk(pf->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }

-- 
Jens Axboe

