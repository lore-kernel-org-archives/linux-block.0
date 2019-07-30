Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA3CC433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 11:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8225B20644
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 11:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfG3Lnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:43:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35891 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfG3Lna (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 07:43:30 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsQXQ-0001aD-Rc
        for linux-block@vger.kernel.org; Tue, 30 Jul 2019 11:43:29 +0000
Received: by mail-pf1-f197.google.com with SMTP id 6so40658199pfz.10
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 04:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4KlUTmLKGdfGcyISyvot6nwpcs6RPe9hQLv7GSaByVg=;
        b=EDYzy5k0xUHOfu7ItbGdsMLGcJgxdilfWnkz9CTxMDN3/LJffJjtR89FIp1MxBMP1d
         7s2AIm8iz1KDJZKD+jNJ3VEY8Idr7wtV3K6UiEvPws57Bl6Pme1uKZW6AjLBupZ8m8TZ
         5zq8fl5kZYpOMtqZ8+Dk0UDWzC0hxDZptr4OjpSD7SndUpbGPrYF5ZtOivR/BJYdYf9x
         hTj+697mUgpalpoZ8Vw4Pht+OkFseorAnk2faWNdinzKH4EC+CTCvQXDRXAReoTW6mXv
         vmixnb09s76rPxYQ0gLVbj1qMHguuNbPQASyBfdW47KW56d9L6X/ZNAkEVhbkzTfh1MB
         ckAA==
X-Gm-Message-State: APjAAAW2FHw11g9JGWecLxP1PLE7Z7wO1mLlUxBpL+XvRG+vsQj//Wws
        tArXwmLv6LR/MfLPrp9S9YMIrF/vlPeDn7cBuAFfoDlLJCDDljxoE7ud+w9w52ZZdBHmm3FxCDw
        +wq1BjLKJBfCUoDV0oqSxoHu6crc6RjNKuqZf4WaQ
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr116845249pjb.30.1564487006913;
        Tue, 30 Jul 2019 04:43:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRl52zNy+T+lE1SC0yFNVABBNPatQQwwGO3yIZ8cF/begXpLwDZ8umDmsu9XwfWTGqFDNHDA==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr116845234pjb.30.1564487006684;
        Tue, 30 Jul 2019 04:43:26 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id s67sm66340537pjb.8.2019.07.30.04.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:43:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for
 raid0
To:     NeilBrown <neilb@suse.com>, linux-raid@vger.kernel.org
Cc:     jay.vosburgh@canonical.com, songliubraving@fb.com,
        dm-devel@redhat.com, Neil F Brown <nfbrown@suse.com>,
        linux-block@vger.kernel.org
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com>
 <87wog0l6u2.fsf@notabene.neil.brown.name>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <20348d5f-fa41-58f1-a7d8-2989233b97f1@canonical.com>
Date:   Tue, 30 Jul 2019 08:43:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87wog0l6u2.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/07/2019 21:11, NeilBrown wrote:
> [...]
>> -	else {
>> +
>> +		if ((mddev->pers->level == 0) &&
> 
> Don't test if ->level is 0.  Instead, test if ->is_missing_dev is not
> NULL.
> 
> NeilBrown

Hi Neil, thanks for the feedback. I'll change that in a potential V2,
(if the patches are likely to be accepted), good idea.
Cheers,


Guilherme


> 
> 
>> +		   ((st == clean) || (st == broken))) {
>> +			if (mddev->pers->is_missing_dev(mddev))
>> +				st = broken;
>> +			else
>> +				st = clean;
>> +		}
>> +	} else {
>>  		if (list_empty(&mddev->disks) &&
>>  		    mddev->raid_disks == 0 &&
>>  		    mddev->dev_sectors == 0)
>> @@ -4315,6 +4329,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
>>  		break;
>>  	case write_pending:
>>  	case active_idle:
>> +	case broken:
>>  		/* these cannot be set */
>>  		break;
>>  	}
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 41552e615c4c..e7b42b75701a 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -590,6 +590,8 @@ struct md_personality
>>  	int (*congested)(struct mddev *mddev, int bits);
>>  	/* Changes the consistency policy of an active array. */
>>  	int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
>> +	/* Check if there is any missing/failed members - RAID0 only for now. */
>> +	bool (*is_missing_dev)(struct mddev *mddev);
>>  };
>>  
>>  struct md_sysfs_entry {
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index 58a9cc5193bf..79618a6ae31a 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -455,6 +455,31 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
>>  	}
>>  }
>>  
>> +bool raid0_is_missing_dev(struct mddev *mddev)
>> +{
>> +	struct md_rdev *rdev;
>> +	static int already_missing;
>> +	int def_disks, work_disks = 0;
>> +	struct r0conf *conf = mddev->private;
>> +
>> +	def_disks = conf->strip_zone[0].nb_dev;
>> +	rdev_for_each(rdev, mddev)
>> +		if (rdev->bdev->bd_disk->flags & GENHD_FL_UP)
>> +			work_disks++;
>> +
>> +	if (unlikely(def_disks - work_disks)) {
>> +		if (!already_missing) {
>> +			already_missing = 1;
>> +			pr_warn("md: %s: raid0 array has %d missing/failed members\n",
>> +				mdname(mddev), (def_disks - work_disks));
>> +		}
>> +		return true;
>> +	}
>> +
>> +	already_missing = 0;
>> +	return false;
>> +}
>> +
>>  static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>>  {
>>  	struct r0conf *conf = mddev->private;
>> @@ -789,6 +814,7 @@ static struct md_personality raid0_personality=
>>  	.takeover	= raid0_takeover,
>>  	.quiesce	= raid0_quiesce,
>>  	.congested	= raid0_congested,
>> +	.is_missing_dev	= raid0_is_missing_dev,
>>  };
>>  
>>  static int __init raid0_init (void)
>> -- 
>> 2.22.0
