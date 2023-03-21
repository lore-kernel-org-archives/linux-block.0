Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C55DC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCURXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCURXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 13:23:16 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816DDBD4
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 10:23:11 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so21036676pjt.2
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 10:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRM5SndGG7ZyzGAaiKvtcFguZJfbJplBf/Qs+wzH8t8=;
        b=EzESjtZulgfVCEpLor8NYswNGl9C69oH8q1Www+lWtvNr5MClNhNwKRuEbpEO173wO
         Pj7ZloeiPM6UV1iI1c2OHS16E+SgSS+cazcNu4ipvZo5UTC9PpKon/y3HaPn3xh3bCkH
         +uMNdmySxxbYL2S3WmLFvBahK6p2SAHBhN1hR4qluxZIAS35fscLcGrmlJlnjtAAsGsn
         bJIuy/2ynX3Wd/PiS7puy0xjBKD+DrtWXL4wH9Gz4boD92Ky4Vqq4hr9h2Q35SOS0Fzf
         1faB9D+mkD3mHepbFrbPUBeA2ykPHcYqzUXaayR9iNx4UVXUnJZ62fkl6JjCAUka4/0X
         5/QQ==
X-Gm-Message-State: AO0yUKUzYgoyISC5KhnJGNDMrx75QL5KPyzjwt5ISPVxrwhUs8SiDTWa
        VCKri5q4SLpS3p7yAzu74TU1pDM6K2w=
X-Google-Smtp-Source: AK7set+t9aV1iH35VYtmcMCmfzrvo3DzlO1Feb35gjx5ieXqBt3NfXWNuD+Urhn9INmiLYD/W39MEw==
X-Received: by 2002:a17:903:124b:b0:19d:244:a3a8 with SMTP id u11-20020a170903124b00b0019d0244a3a8mr3864601plh.10.1679419390934;
        Tue, 21 Mar 2023 10:23:10 -0700 (PDT)
Received: from ?IPV6:2620:0:1000:2514:f23:85c2:2a1f:f1f8? ([2620:0:1000:2514:f23:85c2:2a1f:f1f8])
        by smtp.gmail.com with ESMTPSA id bi11-20020a170902bf0b00b0019f11caf11asm9033335plb.166.2023.03.21.10.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:23:10 -0700 (PDT)
Message-ID: <71f21703-a682-c148-1064-f9ab18c83480@acm.org>
Date:   Tue, 21 Mar 2023 10:23:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bug report] WARNING: CPU: 11 PID: 4009 at fs/proc/generic.c:718
 remove_proc_entry+0x192/0x1a0
Content-Language: en-US
To:     Changhui Zhong <czhong@redhat.com>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
References: <CAGVVp+VB8_8uySZgX2R-rXrTWaL+P0SB4ghKe_4uObqwAgHQHg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGVVp+VB8_8uySZgX2R-rXrTWaL+P0SB4ghKe_4uObqwAgHQHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/23 20:16, Changhui Zhong wrote:
> [  259.090462] remove_proc_entry: removing non-empty directory
> 'scsi/scsi_debug', leaking at least '12'

Please merge Linus' master branch into your branch to help with 
verifying whether the following patch fixes this issue: be03df3d4bfe 
("scsi: core: Fix a procfs host directory removal regression").

Thanks,

Bart.

