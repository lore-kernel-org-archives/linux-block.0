Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCAAC3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C2120870
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ghsQIPoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgCDSsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:48:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43261 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 13:48:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id q18so2676886qki.10
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 10:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwAu9ms1QlnsyjqjRoDdlFh/CoyENRzdXwbEfO2QfE8=;
        b=ghsQIPoKYt5kavTIwPK3kv7RSD3Ayc3Vq13Nd8fuufcYVmwNukXiA4Vl+Qrxlz2JoS
         UoyU3PnqbqKY47c7cEIzeXVY7EhXTi1VVkXhuFTpidkPzk4WCwBKlN9rJvtcp6E41lDD
         Cars9e+Av8jL04fQgth3tHvfnQGHeURhp8JtwfM6l49pIY/hzfYWFpbOIPBHR8AtOcci
         XdTNQ5Tg7/fJRhonxob1XfwoSk4GGm2+ztEyUeRHvzMIY4UH8RMjNYEv9cwY5m7M2VaS
         gEkls0z2eHFseavMSgxK0NpY3mwxIw/RrMu5PB0OvSZiPA3jhEW5rYkkymcHNyEgGoy5
         qtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwAu9ms1QlnsyjqjRoDdlFh/CoyENRzdXwbEfO2QfE8=;
        b=bitHBreBVnPULS1rrNjcmsQmkOhYWnNrvgW9lj8/4hdLcqKpV8lyxWUH84MT1Gj41H
         hwTZpRQaP2ZuzT2ceoFtB7OCW0wCRb+vZMyLXKk3S/KuztkX3guFFf+cBSvXLUlvg1D0
         jiWC9c5lhEu+ZqHGXJAEpxPlU2XdJWi/oik1qB1WFE+FGumE/0epOiU12qoQBgc5Tsk/
         TVhIOirk9D4JcCzGqwrthWlZBpzU3tl20xQN1LuiSactgdtLxol9EdtG/dMTik43Ra/S
         54tlZrIcSUqBMAyqTmCT92Ly0tYTz+wsjs2Nnhr1hhhpxROr6NAKY+LhDVaMXrPWEz1k
         dhaQ==
X-Gm-Message-State: ANhLgQ27T4a4NfxG1oR0fsXSRPPI3dDIJ/l7Bc4zvWxWiUz0iwST3yzh
        u2Vu38PLOLTWGlflX/0+B55zmw==
X-Google-Smtp-Source: ADFU+vtOy/WgHyHX5ovPEB0ebccX19/lh6rFyqX7Z/FfXl9F0FyHVRH2k1rZFkRhTbg/JTXsFaE3Ig==
X-Received: by 2002:a05:620a:13a9:: with SMTP id m9mr4414360qki.359.1583347707934;
        Wed, 04 Mar 2020 10:48:27 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i1sm9122768qtg.31.2020.03.04.10.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:48:27 -0800 (PST)
Subject: Re: [PATCH 1/2] nbd: enable replace socket if only one connection is
 configured
To:     Hou Pu <houpu.main@gmail.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
References: <20200228064030.16780-1-houpu@bytedance.com>
 <20200228064030.16780-2-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fcfdb11d-3af0-0807-b06c-8ca69723a47b@toxicpanda.com>
Date:   Wed, 4 Mar 2020 13:48:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228064030.16780-2-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/20 1:40 AM, Hou Pu wrote:
> Nbd server with multiple connections could be upgraded since
> 560bc4b (nbd: handle dead connections). But if only one conncection
> is configured, after we take down nbd server, all inflight IO
> would finally timeout and return error. We could requeue them
> like what we do with multiple connections and wait for new socket
> in submit path.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>

Alright turns out I'm an idiot, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

