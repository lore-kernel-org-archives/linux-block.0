Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250CCC433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DE364E3C
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 15:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhBAPqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:46:30 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:37123 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBAPq0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 10:46:26 -0500
Received: by mail-pl1-f175.google.com with SMTP id e12so1006427pls.4
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 07:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X70HM1Jnz3qrVVjbkN2EvIvS8g7eAJX5EFfgJe7cNBI=;
        b=oR+gtB1VVSIjDzIWa8OWjEmQo4zi9jzn2hkz/tLkl8iIgCKJL60MDHW2UR25UnYgQ0
         X4S0ND8bkR05/TSOkqWgWiJ2iD7OG7ZA4N8SKJB9YaSUDhZc5+hKkLLnNTifjxtNpnDr
         BQeRKMJAeDvenhpK5eBIuEhTZrRuf17ntO4CjAou3vHaaEUKMyvNpI/X2OsA9nmRDOoC
         muB/wwRs8rscguEEKdZntW/Drg708WBJ5ltmCS6q0xN4G1bRGoHJ+zCZRfVYJHSntI96
         7Ht8iClYwF/CX42fGTB9F9Dccl6TEc7kzxB/OZg2s7lOLpfneO7Cne4Tdrjy0mOUWk/v
         AN0Q==
X-Gm-Message-State: AOAM532WZ1qOWJsrFuyi+kElUogp3DFfwhwNw93nqPEpSfqpy0zloPRg
        f4Bzemzhx4oJTGi67gfTR8I=
X-Google-Smtp-Source: ABdhPJyeqD6ibhG9JLW/yNlRnv2IHGp1UBDL/FUZSQN1RTR1OXdZgBRh8yV0p9jPrhMzMtrLDPEx0w==
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr17169051pjb.41.1612194346196;
        Mon, 01 Feb 2021 07:45:46 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m18sm18345641pfd.206.2021.02.01.07.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:45:44 -0800 (PST)
Subject: Re: [dm-devel] [PATCH 0/2] block: blk_interposer v3
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, hare@suse.de,
        ming.lei@redhat.com, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     pavel.tide@veeam.com
References: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5c6c936a-f213-eaa3-f4fb-3461a0b4dbe1@acm.org>
Date:   Mon, 1 Feb 2021 07:45:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/21 9:12 AM, Sergei Shtepa wrote:
> I`m ready to suggest the blk_interposer again.
> blk_interposer allows to intercept bio requests, remap bio to
> another devices or add new bios.
> 
> This version has support from device mapper.
> 
> For the dm-linear device creation command, the `noexcl` parameter
> has been added, which allows to open block devices without
> FMODE_EXCL mode. It allows to create dm-linear device on a block
> device with an already mounted file system.
> The new ioctl DM_DEV_REMAP allows to enable and disable bio
> interception.
> 
> Thus, it is possible to add the dm-device to the block layer stack
> without reconfiguring and rebooting.

What functionality does this driver provide that is not yet available in 
a RAID level 1 (mirroring) driver + a custom dm driver? My understanding 
is that there are already two RAID level 1 drivers in the kernel tree 
and that both driver support sending bio's to two different block devices.

Thanks,

Bart.
