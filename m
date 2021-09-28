Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A837C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 12:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200B760F21
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhI1M3w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbhI1M3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 08:29:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC519C061604
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 05:28:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i62so11065951ioa.6
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUW2/IJFZY83nPJmflQgcvtOV5+nVA8I+eyXlqMJPRU=;
        b=3rbyBzZUI4kM0wtWn3uTCiL+iFQn37kynJEfwzTuvV788lRHsOgrxQX//6Ptwtyvhm
         PRk4feijU3wh94ty5i1N66Ig+sABpOoZVeSM47DP356owZxXG4KVg3Qk+fU5UpN7qjXC
         jeSW+Bttk5kETwDV3GWvC4MYYvgsuJqIuQTZDyroLwERBzQS4FN9yhIxNHryOdoEOwa3
         o/15DNQGaey/vFs6hguKBx6L7zxTznRm9cJa3vz3CKspK4BMmY/hSPddKOKPDaXtB5dT
         Z+Mr9kmkrhnMk9UXoVcl7QPhre4NUeznnkriL3TH5rbTeZtGvIvFfgKW43pdABZ6Z0cz
         KdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUW2/IJFZY83nPJmflQgcvtOV5+nVA8I+eyXlqMJPRU=;
        b=bHC93H9eBeegRAJeh+HPtM72QJBrp1jgIXzcSkUrlA5k/rdcl3Fmf+Eq+r+1BpjDiA
         vP2iRBVyrBtslgVQJaOADer0a9vnw62tKzDimqHiwf3cA2O5LJrC2sOHy9MPNOE/Dyr+
         x371If8ls2da9yQDfOwZ8o4XVzrmGeLVx5GYjhh8sH0dkrr3+GAPloiVFwqKKrL7Czlm
         BPa5zhC2lWkOz2y4YCpSt3JVHmDKkLK/jMQ1g89fxvlRD47Vwt995X2Ulkvd8twIMn3z
         8kse/Mjb0xG7Gq+VSX6dJcVrP3u7gh3S7nCbo5VfvczMTgT1PURioMmqPFzWCMBnjd7M
         OtUw==
X-Gm-Message-State: AOAM5310EeCS8boi8tESBNdmf3WLZPApwKgJFXxDyT6axXH6MJynFxYh
        WwGCu+vtJuYIH+IXw72WUifASg==
X-Google-Smtp-Source: ABdhPJwPZLFitXCog7R4G/mZxZzFOE8+azMCqbj1uCZcF9QhbMc4aOBoMdp9+4PWoLOwgLvLP0Uqqg==
X-Received: by 2002:a6b:5114:: with SMTP id f20mr3764704iob.97.1632832092364;
        Tue, 28 Sep 2021 05:28:12 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm856634ile.20.2021.09.28.05.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:28:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] block: 5th batch of add_disk() error handling
 conversions
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com, hare@suse.de,
        maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        colin.king@canonical.com, shubhankarvk@gmail.com,
        baijiaju1990@gmail.com, trix@redhat.com,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, oberpar@linux.ibm.com, tj@kernel.org,
        linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210927220232.1071926-1-mcgrof@kernel.org>
 <25afa23b-52af-9b79-8bd8-5e31da62c291@kernel.dk> <YVLV3s66GVVSQ+tj@osiris>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bfd9f85a-d6fb-c05a-5ec3-2e15ee08062d@kernel.dk>
Date:   Tue, 28 Sep 2021 06:28:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YVLV3s66GVVSQ+tj@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/21 2:44 AM, Heiko Carstens wrote:
> On Mon, Sep 27, 2021 at 04:32:17PM -0600, Jens Axboe wrote:
>> On 9/27/21 4:02 PM, Luis Chamberlain wrote:
>>> This is the 5th series of driver conversions for add_disk() error
>>> handling. This set along with the entire 7th set of patches can be
>>> found on my 20210927-for-axboe-add-disk-error-handling branch [0].
>>
>> Applied 1-2.
> 
> Hmm.. naturally I would have expected that the dasd patch also would
> go via block tree. But let's not spend too much time figuring out what
> gets routed where.
> Applied 4-6. Thanks!

I left the ones that have active maintainers for them to pick. Unless
someone has already acked/reviwed it, in which case I picked it up.
I've got no problems picking them up directly, but unless it's been
reviewed by the maintainer, I prefer if they either do so or pick
them up.

-- 
Jens Axboe

