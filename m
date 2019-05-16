Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA24C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4222B2087B
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wtd5YV/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfEPOJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:09:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37522 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfEPOJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:09:33 -0400
Received: by mail-it1-f193.google.com with SMTP id m140so6475495itg.2
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nvTEa3W0LilyOufVo8nEIfF6KLkAsq/kO20AWZ+aqaw=;
        b=Wtd5YV/X1PGOU13pxxLFsOSt26Ob6P4eSLyXSS4HTQe3BWhFiu5jV2JbglUrVWKIoY
         2Rbdiy5tb3f1qa39+JwW63qvpIGYEcsE65eGkkDmfGz2HZL0DE4q3LhbDZvjWsBdZliL
         vP5/Pk98RGoefblxlpd6xNAiLAk4ZwLA7eXfcTA/t4lLNgnxOcNM/Ymm70elBcOklWGh
         gBx5HKMJ1hlpibHMLzW0ZrrDDOsO0CeXAAv5ec60pPlyzqNrdZoAClNMEUHE2S2V7YsH
         He3+xvNAW/OJ9qmxRsaQuUpNNHx7n+1qjCbcqO7xfg9wGk5zozN36FqefRufobVu1mRD
         azeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nvTEa3W0LilyOufVo8nEIfF6KLkAsq/kO20AWZ+aqaw=;
        b=MY0kwjCmydd9yDWf6sq9izjeW9M3ZmaZ9GBR3r+F0bq29tc1djsMYUsiefvbFontJJ
         oZtVYSVDgM+qKmNvsyAuD7xewVIcm8fmosoLIRIYUut75E7z49+PhibaW8ZLJxVVA0vf
         OtglbrLTwGQ/WGa3PEPkhYKcvoVKn2M7c03y8sneE56GaibxMnKmDVY1X/kXZAr+Lux5
         Cx0ZY+WsHor8cwH6SK4EyWLvarzJTVsu6vomXyx9iry6zG9tuoASIllqdRu8hM+BNDYk
         dTBdwXiLBK6QVhnzssD+54NXJUUnw4qgt9f+kvnDbW1FZK6Bx4TJyzXyS8gVfHHEZKkt
         vKzQ==
X-Gm-Message-State: APjAAAWsrn2wkGGdfHRZjtvS+pFtf263/1fRRaKVcFtvFGlLCF+2efVF
        XIhAhbK6CE8uvdAqdulnY+hwxLIaiaYzGQ==
X-Google-Smtp-Source: APXvYqyjn7LNYS+6Vj3zFCFwcCEROb5g0XiJwJsufU1kr1PJ3NEvPdk6bpggJl5t+vpGXPxxOwvrUg==
X-Received: by 2002:a24:2e17:: with SMTP id i23mr1258603ita.100.1558015772560;
        Thu, 16 May 2019 07:09:32 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k76sm1703590ita.6.2019.05.16.07.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:09:31 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190516082541.GA19383@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2c12d06-acd0-ea82-c63c-a068ec5ae1fe@kernel.dk>
Date:   Thu, 16 May 2019 08:09:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516082541.GA19383@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 2:25 AM, Christoph Hellwig wrote:
> The following changes since commit 936b33f7243fa1e54c8f4f2febd3472cc00e66fd:
> 
>   brd: add cond_resched to brd_free_pages (2019-05-09 12:51:27 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.2
> 
> for you to fetch changes up to 1b1031ca63b2ce1d3b664b35b77ec94e458693e9:
> 
>   nvme: validate cntlid during controller initialisation (2019-05-14 17:19:50 +0200)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (1):
>       nvme: trace all async notice events
> 
> Christoph Hellwig (2):
>       nvme: change locking for the per-subsystem controller list
>       nvme: validate cntlid during controller initialisation
> 
> Gustavo A. R. Silva (1):
>       nvme-pci: mark expected switch fall-through
> 
> Hannes Reinecke (2):
>       nvme-fc: use separate work queue to avoid warning
>       nvme-multipath: avoid crash on invalid subsystem cntlid enumeration
> 
> Max Gurtovoy (1):
>       nvme-rdma: remove redundant reference between ib_device and tagset
> 
> Maxim Levitsky (2):
>       nvme-pci: init shadow doorbell after each reset
>       nvme-pci: add known admin effects to augument admin effects log page
> 
> Minwoo Im (2):
>       nvme-fabrics: remove unused argument
>       nvme: fix typos in nvme status code values
> 
>  drivers/nvme/host/core.c      | 79 ++++++++++++++++++++++---------------------
>  drivers/nvme/host/fabrics.c   |  4 +--
>  drivers/nvme/host/fc.c        | 14 ++++++--
>  drivers/nvme/host/multipath.c |  2 +-
>  drivers/nvme/host/pci.c       |  4 +--
>  drivers/nvme/host/rdma.c      | 34 +++----------------
>  drivers/nvme/host/trace.h     |  1 +
>  include/linux/nvme.h          |  4 +--
>  8 files changed, 64 insertions(+), 78 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

