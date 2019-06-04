Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E342FC28CC3
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA9420828
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 19:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kSGpqLi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDTio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:38:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36183 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFDTio (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 15:38:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so3541572pgb.3
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2019 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5awe/yDakGGO/BxwxBGm2kDwtqm01hxaeRIR5WSClTE=;
        b=kSGpqLi9hgVEttJY+zJphTmom5Q5BaBDXDBe5zqhVVAGx7/lugNzzuHC7qLjH6bnXr
         IUe2OT/8ZM/oxAdRpwwWcyUEv7AUKPVc3AYzfI/eItQVRaisMwh9h7SPmJZvCIYcZO8E
         k0KU0cJ86d1ViyKOEcuw5rfV9Iturz7XlAV/RSWm36Eo82G5fTfwPv19U8bu4Gqxr+CM
         BOCLx6BdgS+3LP7moHlYOItVLkSA+uR6lvepvP/wm0DjH8S9/gjwkn3dESclnow+ueU/
         4U/x1D5g4h53bvUfCc0X3Likoos40SvliquEQdlR35M4pDRvMfbhkhbCoZHuLe1G8KmI
         OGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5awe/yDakGGO/BxwxBGm2kDwtqm01hxaeRIR5WSClTE=;
        b=d1XzXizyyBCTWDKth2Jgn/I9D18jTVS/+ruUGqft8eBQIx5PtL+8UcCrJxeDpxjXK+
         zyV61FKlr4bbHDGzIK7PgmWdTvMCZhu9A/AIHN9hdlpe5b39jwTKpbJj6pKdIk3dLCtv
         o8h2lRxNdt5OCQWqwlQvmlNAO6ujUJg/M6Qn7uq4H1tu5IASqplHLn87cXZhtqG7kQ51
         3b8pPgrbYV4RyAIXC/YZpG/16CXuFVsVoYM/GaUOIxz/j+GNm9amgDhM5HVCDNorJKSH
         n37xlmlWCN2qsY/zyZY3IpdiS1ZtYHzDKpDRTcRNLCx0BEQon3oDgmwOoWopUUVTzr4v
         m1Cw==
X-Gm-Message-State: APjAAAVxcvacgL12UTTrqLhNwd5H7FtAoD3RIifQYpBrkntPe+a5UBCe
        REKlqYqoiEm+w3RUCN/WlFE8xHbnHvQjYg==
X-Google-Smtp-Source: APXvYqzdwHso23dJP5b3wNfTmRHfedIauNzwirK6VyEPimLWGvRmxSf7WGgEInbzWLKS1kSSfaNzKg==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr295216pgc.140.1559677123064;
        Tue, 04 Jun 2019 12:38:43 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c129sm21243833pfa.106.2019.06.04.12.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 12:38:41 -0700 (PDT)
Subject: Re: [PATCH v3] block: aoe: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Justin Sanders <justin@coraid.com>,
        linux-kernel@vger.kernel.org
Cc:     "Ed L. Cashin" <ed.cashin@acm.org>, linux-block@vger.kernel.org
References: <20190122152151.16139-5-gregkh@linuxfoundation.org>
 <20190603194754.GB21877@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <168b8cf5-15ed-a4c1-6393-4f8df336a68e@kernel.dk>
Date:   Tue, 4 Jun 2019 13:38:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603194754.GB21877@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/19 1:47 PM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Applied, thanks.

-- 
Jens Axboe

