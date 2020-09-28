Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EDAC2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 11:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7182080A
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 11:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMYFoifk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1LGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1LGH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 07:06:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7EBC061755;
        Mon, 28 Sep 2020 04:06:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j2so817927eds.9;
        Mon, 28 Sep 2020 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zmRNc4An8EyDOMtea3peb6h9QyFwPP8MpY42ocop9rA=;
        b=hMYFoifk1kYv0MKY5pOwwCCcQrjIvVCgDv9blzQ4wN5rTrbrhLIOJgc/B6LcEkUlcJ
         E22KfY/FfB5866R8XtMlEpoWfpdzVZlU2ghgmSvrpqP/uOUz+pxuHfixBNqV4YGft6Pv
         Eoenvzi6DRV1n+Xe8iezoe3NzDQQ+XURHatMRR/riHkcqX6HbwvGj44f7+2Y6x7qjOY6
         7JFTzXYSLvW3B801OT+1Ur/2jFFE4CB9LrDFU17NMgXkUtT60NyDCw5kd05pivODmLCH
         M0wkF9T03Tdl+m1ntUTt0XFOz2FwDM3AIF8rxqaG8Rtb4LhqYqOnvGg0wIMf3VMUi9aN
         wbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zmRNc4An8EyDOMtea3peb6h9QyFwPP8MpY42ocop9rA=;
        b=kpBLcJFK69NVMUVAmZageVe0nS9HS/3D4yj0Q5YSnTWkZYY/98rNX3z7DgKJT5OkhR
         7xh1kPtyW8NLpAD3395tSVUnyZD5+i2TSsP9rSijgL+0QrFu2kci/0ELyakCJE0VAxAh
         mBVtmMBYDd2JlcYxZLuW7eMgwYS6AW7KPQeafzfE1aDa8wJq8LIN9hbknXrif3U4fV3N
         lVNSHGCgx1vl7KWJJjJo3Yj18zaX+9iEtaIQdx0T0NQjL/DI9XuuYaNSgq+C+Q7YEQVl
         F5QgSuktdF3BqmGJQ68zf+KvMxk4L0jjdPEoYqPVFv0EjtavOrbpMVqh5hnsOf9nUP7+
         UwfQ==
X-Gm-Message-State: AOAM532Rbq7lA+gXQqQ63dIvSHny/XWRVSM/BBHk1BjHXDx9779BIMew
        93YMpXAe/W17B6cYmA50pF4=
X-Google-Smtp-Source: ABdhPJyUvwgcWFuM1/ZAL2oEjX72VcqbT8HT/4JCVbHnqa3YJNqX9EIMYgwZA4O71AkgCjTLyqcmfw==
X-Received: by 2002:a50:a6c2:: with SMTP id f2mr1059960edc.227.1601291166165;
        Mon, 28 Sep 2020 04:06:06 -0700 (PDT)
Received: from [10.10.0.8] ([141.98.255.143])
        by smtp.googlemail.com with ESMTPSA id l21sm862925ejg.124.2020.09.28.04.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 04:06:05 -0700 (PDT)
Subject: Re: Deadlock under load with Linux 5.9 and other recent kernels
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org, furkan@fkardame.com,
        Brad Harper <bjharper@gmail.com>
References: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
 <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
 <EE8C801E-0AD8-43E2-9C65-92CD512904BE@gmail.com>
 <c431ae48-6913-acc0-dc0a-b52065e9eaed@kernel.dk>
 <91886A80-8164-4699-8662-E7D3444A4F12@gmail.com>
 <BA41AA25-8647-474E-87E6-64D4F030E590@gmail.com>
From:   Patrik Nilsson <nipatriknilsson@gmail.com>
Message-ID: <c05ae5ee-535d-ad2a-ce7e-137c428eb83b@gmail.com>
Date:   Mon, 28 Sep 2020 13:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BA41AA25-8647-474E-87E6-64D4F030E590@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

To me this bug description is very similar to what I'm struggling with 
on an amd64-platform.

When I get too much data sent via usb, it seems as the usb controlmsg is 
delayed so it times out and unmounts the block device.

I have been working on my related bug for long to get it easily 
reproducible, but failed. It is there all the time. New hardware is on 
its way so I can continue my testing.

Maybe you can test the patch I'm using to see if it works better for you?

In the meanwhile here is my description of my bug:

> I have stress tested the usb system. To the USB is now seven 
> mechanical hard disks and two ssd disks connected. Six processes are 
> at the same time writing random data to the disks. One of them is to 
> the ssd disk I couldn't write data to before without it failed. Also 
> the other usb-ssd disk is my root partition.
>
> Before I applied the patch, my root partition sometimes failed to be 
> kept mounted. Now I have not had any crashes.
>
> This is a quick fix for hard disks, but working. It continued to work 
> when I started three virtualbox guests and let them also do work. The 
> guests' hard disks is on my usb-root partition.
>
> It doesn't work if I also use my usb2ethernet adapter (ID 2001:4a00 
> D-Link Corp.), although my root partition and two randomize tests 
> survived. Maybe a much larger timeout in this case will help? But this 
> I don't find as a good solution.
>
> The behavior is the same on the other (much slower) computer with a 
> different usb hub. I have also tested it with exactly the same setup 
> as earlier, with no mechanical hard disks, and it works with the patch 
> and not without it.

Best regards,
Patrik

---start of diff---
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5b768b80d1ee..3c550934815c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -105,7 +105,7 @@ MODULE_PARM_DESC(use_both_schemes,
  DECLARE_RWSEM(ehci_cf_port_reset_rwsem);
  EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);

-#define HUB_DEBOUNCE_TIMEOUT    2000
+#define HUB_DEBOUNCE_TIMEOUT    10000
  #define HUB_DEBOUNCE_STEP      25
  #define HUB_DEBOUNCE_STABLE     100

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 20c555db4621..e64d441bb78f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1841,8 +1841,8 @@ extern int usb_set_configuration(struct usb_device 
*dev, int configuration);
   * USB identifies 5 second timeouts, maybe more in a few cases, and a few
   * slow devices (like some MGE Ellipse UPSes) actually push that limit.
   */
-#define USB_CTRL_GET_TIMEOUT    5000
-#define USB_CTRL_SET_TIMEOUT    5000
+#define USB_CTRL_GET_TIMEOUT    10000
+#define USB_CTRL_SET_TIMEOUT    10000


  /**
---end of diff---


On 28/09/2020 03:37, Christian Hewitt wrote:
>> On 26 Sep 2020, at 4:28 pm, Christian Hewitt <christianshewitt@gmail.com> wrote:
>>
>>> On 26 Sep 2020, at 4:13 pm, Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 9/26/20 5:55 AM, Christian Hewitt wrote:
>>>>> On 26 Sep 2020, at 2:51 pm, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 9/26/20 1:55 AM, Christian Hewitt wrote:
>>>>>> I am using an ARM SBC device with Amlogic S922X chip (Beelink
>>>>>> GS-King-X, an Android STB) to boot the Kodi mediacentre distro
>>>>>> LibreELEC (which I work on) although the issue is also reproducible
>>>>>> with Manjaro and Armbian on the same hardware, and with the GT-King
>>>>>> and GT-King Pro devices from the same vendor - all three devices are
>>>>>> using a common dtsi:
>>>>>>
>>>>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
>>>>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
>>>>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
>>>>>> https://github.com/chewitt/linux/blob/amlogic-5.9-integ/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
>>>>>>
>>>>>> I have schematics for the devices, but can only share those privately
>>>>>> on request.
>>>>>>
>>>>>> For testing I am booting LibreELEC from SD card. The box has a 4TB
>>>>>> SATA drive internally connected with a USB > SATA bridge, see dmesg:
>>>>>> http://ix.io/2yLh and I connect a USB stick with a 4GB ISO file that I
>>>>>> copy to the internal SATA drive. Within 10-20 seconds of starting the
>>>>>> copy the box deadlocks needing a hard power cycle to recover. The
>>>>>> timing of the deadlock is variable but the device _always_ deadlocks.
>>>>>> Although I am using a simple copy use-case, there are similar reports
>>>>>> in Armbian forums performing tasks like installs/updates that involve
>>>>>> I/O loads.
>>>>>>
>>>>>> Following advice in the #linux-amlogic IRC channel I added
>>>>>> CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_DETECT_HUNG_TASK and was able to
>>>>>> get output on the HDMI screen (it is not possible to connect to UART
>>>>>> pins without destroying the box case). If you advance the following
>>>>>> video frame by frame in VLC you can see the output:
>>>>>>
>>>>>> https://www.dropbox.com/s/klvcizim8cs5lze/lockup_clip.mov?dl=0
>>>>> Try with this patch:
>>>>>
>>>>> https://lore.kernel.org/linux-block/20200925191902.543953-1-shakeelb@google.com/
>>>> It still locks up approx. 25 seconds into the copy operation. Here’s the output in video again (a little blurry):
>>>>
>>>> https://www.dropbox.com/s/3j2czaq509arg6g/lockup_clip2.mov?dl=0
>>> Can you try and set CONFIG_SLUB in your .config instead of CONFIG_SLAB?
>> CONFIG_SLUB is already set, here’s the full defconfig http://paste.ubuntu.com/p/5BNdZv6J3c/
>>
>> # dmesg | grep -i slub
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
>>
>>> Also, just take a picture, should be easier to get readable than a video.
>>> And the static trace is all that is needed.
>> This is from a GT-King Pro which someone reminded me has a large RS232 port on the rear:
>>
>> https://pastebin.com/raw/sGtzgreN
> from 5.9—rc7 https://pastebin.com/raw/nbHJmrqe
>
> Christian
>
>
>
>
-- 
PGP-key fingerprint: 1B30 7F61 AF9E 538A FCD6  2BE7 CED7 B0E4 3BF9 8D6C

