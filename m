Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5596AC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiG0QFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiG0QFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:05:01 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA64AD61
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:04:59 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w14so1160722ilg.7
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FLvvCmY980ke3qXwdBWhEivVQbQmf48lkfZgSdFBdCc=;
        b=7T4QUrjL05HMgFQZwAeL7dZUImdN4NAYuVkD8S614ZkwSekLpzJ82NCCnrNJdaM6m4
         jdYIUJOo4yc8wouK5YV/7AO71+FNXRkFXndzF9xBKsoHQsNrLDE+9WdEAgtTGapNZJ98
         bzR6TdHYOrng147HgqShbNU/6YStn93aYN0wMJvWp5Dn8L/yQXlOcjjPwgThxhhak0wX
         cicXNtG7LZwMqi2TgFGiZtm9yw+jBFppQrEk/iAj3ZodQWKg9VstMabqaRwZMieKsgdP
         b+RNu4ymgJEFL+p56S205Did6Yr9rx2OPyPoBfazQByKTYtY9NQT3hCBPhi4UMdE5lfR
         2SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FLvvCmY980ke3qXwdBWhEivVQbQmf48lkfZgSdFBdCc=;
        b=udn2aIxqw760mVG8IpVdWKYi/hV5YdRnD5F7320ce1GoUZIxCWP/pOwvu/mHFHHRmt
         qj3/kyXRYA1yu/gyRhoh/jxivtncGuBvSI2OZz7JeI+gOv0Tms5L9od8QQmo1BYjYlZe
         vM++7B+FfzkLqyvKWS8bLacn12ZQG8T7T/QsYQLUdb+PfWUccCLUfOcB52jUtM3YpCtd
         D81pR2T6jG00OyH+AZzz20P6cnL+bQHJjiVXMfza+SZmB/wIgFw/JNHDutJ3wrMv+8IS
         IA21u7FuBUBn2b5rGeisKbi8QvKeFz7fweHCcBDkj6OlcK4/Pf2B1/nU+qc7QlZ/A4SO
         8b+Q==
X-Gm-Message-State: AJIora/mfZFjyNzA4CdWP2vHc0m8RPTl93hMCxHwGHLi50irUnimpIj6
        iCZ1SUEI/ffPOMHzZN4BRIGjdw==
X-Google-Smtp-Source: AGRyM1vDTLyoJ4cgfiftHv/tnoo9CIEYn/60l1ilMS9uAYdCf4K0AbP+qQCVqlkA5UuQXONT+uf9Og==
X-Received: by 2002:a92:b08:0:b0:2dd:af17:f72d with SMTP id b8-20020a920b08000000b002ddaf17f72dmr2722554ilf.196.1658937898884;
        Wed, 27 Jul 2022 09:04:58 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m13-20020a026a4d000000b0034161ed8fadsm8007093jaf.150.2022.07.27.09.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:04:58 -0700 (PDT)
Message-ID: <db5b57db-d395-5ea9-8708-845a09ab4c7f@kernel.dk>
Date:   Wed, 27 Jul 2022 10:04:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme fix for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YuFftyWcAMRP/NC5@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YuFftyWcAMRP/NC5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 9:54 AM, Christoph Hellwig wrote:
> The following changes since commit 82e094f7bd988c02df27f8c8d81af8f750660b2a:
> 
>   Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19 (2022-07-19 12:42:33 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-27

Pulled, thanks.

-- 
Jens Axboe

