Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A23C433FE
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 03:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962F723117
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 03:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395199AbgLLDND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 22:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405302AbgLLDM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 22:12:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F6C0613CF
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 19:12:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id f9so8222185pfc.11
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 19:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NZJoWOMhpPRHyBgUT5gQhUDVKFC6vY6RuzB64G7KlKY=;
        b=I7UfzQ/Yrujusf2hBiW/54GDAq7enRbMYPlg/T3+cJMaYcj5kedcNgopNF8oixXu3p
         xFucLIpiPs9fosA3McexDDZfyECVL/ZsGH9guJVuxwot6Ou0wwmRfVF9I3gMt8UzO7DJ
         ATMNw8p3R6jjPLfPLLToLZuV4vZHI962DlJPP+OJEU2XwQliT+Vz+DKH2OTjuqFTIMsx
         5IcKV/HvjQ95JropngYTEfsu6MLOKUCPt8hLinK+oZR6BU4zkNqEuMybPOuR2vaDZ9r1
         fH5HuEJYIvaOTFN3riKuBpYuF+bxwL7hiziPVOLU8WavHGodL1ben8i6yWPZB8CXsh1t
         YApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZJoWOMhpPRHyBgUT5gQhUDVKFC6vY6RuzB64G7KlKY=;
        b=qwKvQ+b5h8VZTunTkrXGNJxNf5g5GoN5xZABCWHKe1kmjCca9v+Uj9912q4hHl1fhy
         8/laocQMNLtAEse9bpRUtaAXf/K57OZQYrbEB3yyVfIo+eLf4jJqKLBeypJMDOS+KW4p
         5fkbrXou3XZ8xU4bGppWFH7F4NIPBKweIl29n3o8FGQMBAhBgEgirv0y9p8aqIq/5p3t
         lhNsQBwn8yQ1656wYhZq+bhRotlSpPHKCuIuqaECVdDK93hfKK1pkmJFj9i1In+BeYf8
         7yrLSF12FcpGh9kPeAohQOia9bEWsCiaG65zEezQItjZmSZGxLlOEDg/57VYuCPZCxGc
         xiKg==
X-Gm-Message-State: AOAM530lILsJbnytXTdFJFNEG+v4ytgsq7PnNnlv0NTjVwaQz/DhZc0T
        eVPCU0n5ZzeGZqa3dvp3UUJUCIT2ELtZ4A==
X-Google-Smtp-Source: ABdhPJzLlsf8u0814zw3w4Xv7F5BBa+qOrVe7L8TpQVQymk3LxCAYcmSNlos181XPc7EC9j0sh9GTQ==
X-Received: by 2002:a63:1c4e:: with SMTP id c14mr14895453pgm.334.1607742736738;
        Fri, 11 Dec 2020 19:12:16 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k9sm11412834pjj.8.2020.12.11.19.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 19:12:15 -0800 (PST)
Subject: Re: [GIT PULL] Block fixes for 5.10 final
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6f7f4ba2-2de2-b6e7-cbf9-cbad3eaf72db@kernel.dk>
Message-ID: <cdcde1ac-7b1b-a935-dc9b-6612cd587c3f@kernel.dk>
Date:   Fri, 11 Dec 2020 20:12:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6f7f4ba2-2de2-b6e7-cbf9-cbad3eaf72db@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/20 7:57 PM, Jens Axboe wrote:
> Hi Linus,
> 
> A set of reverts for md/raid10 discard changes in this merge window,
> which have been proved to cause corruption in distro kernels. Please
> pull!

Hold off on this please, just now noticed that the last build threw
a minmax warning on this. I'll double check and resubmit it tomorrow,
just to be on the safe side.

-- 
Jens Axboe

