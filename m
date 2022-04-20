Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B745C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 22:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356261AbiDTWqy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 18:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiDTWqx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 18:46:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB72B186
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 15:44:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h5so3022878pgc.7
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OnaxwzhsILozlsanJyRx8nrxZJ7VisjZm8Gz2gv5rvE=;
        b=Lk94nl0YPNCFBwbc9xzbQlTK3NjyR/Hu0wDncR3t+lifFrAC0IOv/3OGZanqaffF8e
         0KZ1Uvt/ohTjqvu5v5CaXSc77uj98MI+enN2XgL4wdq8qezwmRp9JSZ3IG135X3UzjSh
         XyPND2AT2PDSoq9/bxk9scfwdsnyao/dE/04jPcPRvgkMx4veXpGCLr1BHiKb1Lbk1oU
         X4RR15TfHgQauG71+C8i5fOmxnDV3PL7FcqVX4lJ139bBKcawt4GqtFKeps9/yj2EMS1
         rzjc29BP34X9dEhYSELy1yUe49iZAI3qrN3Chxaz7ti68AUC0FZPDr28o6Vi5xJMjqet
         mzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OnaxwzhsILozlsanJyRx8nrxZJ7VisjZm8Gz2gv5rvE=;
        b=jnZS0oXPVY7pQtOhoFwnln5IQ0fUCFO05NdUYYYsitsu9XClfY/L8xDS33Wo2C9d0s
         IzDPCUGG2tkl2R+O1oGO1A/6t8a2WLC74lnX8KsajinmhNCDdIEF8ffs0D/aP9DEK7LZ
         Sn83SQCTWXkH5lwK7f6OsVtR6IvslnWG2JWQcodY6Fv4wFwLGWkzvfU1EdzwMrT4/c9q
         m3Nhz1gM3zvoFY2Xk39LWXtNoHGkhF/DM3iA2eJjW+FzXQPhv7c7QUPE9dqr+hBf5svh
         jiAEmkNhvBqT12bgtAqv7It5fLMjhLr+GO7tdtSHuiCn5ltX6XPOy0YGPz6ofLZDYt9K
         5FNw==
X-Gm-Message-State: AOAM5317++WNA+gA8z5Bdh8EUNSUwgKaXEmklUvD4mRbU4420Vas+X/w
        fTGvr02MPLqQ804N43rE9tBcNw==
X-Google-Smtp-Source: ABdhPJwFdIxToYi4qmWc3uQhwDgZc0Ul/qhUDssq4Fd2zlXc1XKb8ylXBx/uM/hGSl5U2KkF6BEN0w==
X-Received: by 2002:a63:b20e:0:b0:398:5b28:e54a with SMTP id x14-20020a63b20e000000b003985b28e54amr21295297pge.443.1650494646057;
        Wed, 20 Apr 2022 15:44:06 -0700 (PDT)
Received: from ?IPV6:2600:380:4975:46c0:9a40:772a:e789:f8db? ([2600:380:4975:46c0:9a40:772a:e789:f8db])
        by smtp.gmail.com with ESMTPSA id j63-20020a636e42000000b003987df110edsm20952820pgc.42.2022.04.20.15.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 15:44:05 -0700 (PDT)
Message-ID: <34724462-488b-4093-7e8e-e89edcd070fa@kernel.dk>
Date:   Wed, 20 Apr 2022 16:44:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
 <Yl/TjWYle8mOOwlO@T590> <20220420124213.5wc4umnjrlvu6zbi@shindev>
 <YmAhRtOnezJ2EwBl@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YmAhRtOnezJ2EwBl@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/22 9:05 AM, Ming Lei wrote:
> On Wed, Apr 20, 2022 at 12:42:14PM +0000, Shinichiro Kawasaki wrote:
>> On Apr 20, 2022 / 17:34, Ming Lei wrote:
>>> On Wed, Apr 20, 2022 at 01:59:11PM +0900, Shin'ichiro Kawasaki wrote:
>>>> The test case block/002 checks that device removal during blktrace run
>>>> does not leak debugfs directory. The Linux kernel commit 0a9a25ca7843
>>>> ("block: let blkcg_gq grab request queue's refcnt") triggered failure of
>>>> the test case. The commit delayed queue release and debugfs directory
>>>> removal then the test case checks directory existence too early. To
>>>> avoid this false-positive failure, delay the directory existence check.
>>>>
>>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>> ---
>>>>  tests/block/002 | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/block/002 b/tests/block/002
>>>> index 9b183e7..8061c91 100755
>>>> --- a/tests/block/002
>>>> +++ b/tests/block/002
>>>> @@ -29,6 +29,7 @@ test() {
>>>>  		echo "debugfs directory deleted with blktrace active"
>>>>  	fi
>>>>  	{ kill $!; wait; } >/dev/null 2>/dev/null
>>>> +	sleep 0.5
>>>>  	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
>>>>  		echo "debugfs directory leaked"
>>>>  	fi
>>>
>>> Hello,
>>>
>>> Jens has merged Yu Kuai's fix[1], so I think it won't be triggered now.
>>>
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.18&id=a87c29e1a85e64b28445bb1e80505230bf2e3b4b
>>
>> Hi Ming, I applied the patch above on top of v5.18-rc3 and ran block/002.
>> Unfortunately, it failed with a new symptom with KASAN use-after-free [2]. I
>> ran block/002 with linux-block/block-5.18 branch tip with git hash a87c29e1a85e
>> and got the same KASAN uaf. Reverting the patch from the linux-block/block-5.18
>> branch, the KASAN uaf disappears (Still block/002 fails). Regarding block/002,
>> it looks the patch made the failure symptom worse.
> 
> Hi Shinichiro,
> 
> Looks Yu Kuai's patch has other problem, can you drop that patch and
> apply & test the attached patch?
> 
> Jens, looks the patch of "blk-mq: fix possible creation failure for
> 'debugfs_dir'" isn't ready to go, can you drop it first from
> block-5.18?

Dropped, thanks Ming.

-- 
Jens Axboe

