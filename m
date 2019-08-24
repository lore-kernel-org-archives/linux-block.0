Return-Path: <SRS0=IQXF=WU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3896C3A59E
	for <linux-block@archiver.kernel.org>; Sat, 24 Aug 2019 03:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A639921019
	for <linux-block@archiver.kernel.org>; Sat, 24 Aug 2019 03:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfHXDiB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:38:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36443 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfHXDiB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 23:38:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so6716134plr.3
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2019 20:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kTVoI+i1OzxyD1KK+Mc6yIpwDJh7u1+gbcsQAqIkmG8=;
        b=ZSbyzcY2IRdHhQH+tjo6FXB9DBSg9LQvNx3VI/Zk01WMEyTktWRLdUU5WEtavTkqM7
         8a2tyD5ZXp+RfaF7dcDV32Fmg51zXgRtbunMudHfhBH98UgjBvktAU++1B1pJp/e4ivh
         ozPqAVdOkPbt7sBvVFQe3SsWIa0xyMwEzVgIpRoMAmMJoD1Hdo+CQ4P8MrRbm+qwn5k3
         1rALifPp0n3rWNZun3/NMYfvvEjyPjMERn0lILtOpgG9qQy25uRKdsI4oiYpYnDUHFTH
         sp0IlNQgKS/TQu1ol0qGJnC+3rDi+WhNLB43gmm3v/Ytp5uPPXysUMLVDK6ZlyxfcbSA
         WW4Q==
X-Gm-Message-State: APjAAAV+tQSwF1xpn+wqXX5Sj0jdoXSiVRtdYr8glQqY7Z4H3Wav3qgf
        aI65ymu2SQhwfPV0WtJ3tMme0znf
X-Google-Smtp-Source: APXvYqztrrthsfKL5xGiT+ZdGC8oWDOge+EN2vf8SXdOpzYrWaCqseVFgYSsg71653gQeBVUk+78tA==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr8020443plb.52.1566617880587;
        Fri, 23 Aug 2019 20:38:00 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1349:56c2:95e9:3c7:9c11])
        by smtp.gmail.com with ESMTPSA id v8sm3892863pjb.6.2019.08.23.20.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 20:37:59 -0700 (PDT)
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2 file
 format driver
To:     development@manuel-bentele.de, linux-block@vger.kernel.org
References: <20190823225619.15530-1-development@manuel-bentele.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <da0a76ae-0627-24b8-1aa5-62463e8b3759@acm.org>
Date:   Fri, 23 Aug 2019 20:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823225619.15530-1-development@manuel-bentele.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/23/19 3:56 PM, development@manuel-bentele.de wrote:
> During the discussion, it turned out that the implementation as device
> mapper target is not applicable. The device mapper stacks different
> functionality such as compression or encryption on multiple block device
> layers whereas an implementation for the QCOW2 container format provides
> these functionalities on one block device layer.

Hi Manuel,

Is there a more detailed discussion available of this subject? Are you 
familiar with the dm-crypt driver?

Thanks,

Bart.
