Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE575C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 17:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36572082F
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FSXHnqCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfCZR5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:57:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53316 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731761AbfCZR5l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 13:57:41 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so6820541itf.3
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6dwy383dQ6LRVboW0PJg4TARc+HUbTaqlDNY4e3xk5A=;
        b=FSXHnqCVDKAM1kHANbDfWVoaWybd6WwFOizYiNOt0SUzOk17SUKKoIow9v8MfsX3ol
         IxHrlyr6gGkcxZc+Q1QXEghTua+Yb4Ui9XV6feJgOSl6m/Ik5aMfrIoOY6J1s6pT/H5y
         mYcVgveblit1YqhohZ2zFJv3yQOEQ1C41R8w+L6qr3I3CFfMHjObFstvn6j94dZelYK8
         uXIU0cEOtZ/gyjgNpOJU3Upj7Dx7nFnaT0Vwp1f1a1RypkL6tF5jvocnNupNsQJkl5Tb
         MOoNpMmXggmQJax3fKski1GcTMH41Sll3plhtzZjML9DY3TFuJdB5mcxMmsbo/esgCNM
         u1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6dwy383dQ6LRVboW0PJg4TARc+HUbTaqlDNY4e3xk5A=;
        b=Y7VMsbWoXFNe/iYPaKnFsIBx0yob6r/R04itqTD3riIkQDYxVrdBS+U0hd6K4EQtKY
         ZzEuL2jlPwX4uoTBb5E5VPPAia5f4RYQQDc4HI4nG3Vdi7fF1QtsX2IvVFPyRKo+hK/y
         LmwjBCKVtwj4hdMI4uvTh4bNHD1SHyGT51YJo9yWATWkNfFKg49/YGoEC8VIOgKUSX1K
         30TYYSeUN1z/J6h3HpQUNpiTQVyXDqU60wLcVyXpbhTnrEdCTYFS7FIuNCYjzL3ML1vo
         rtCGHvUVZwlafp77C74dmxo42kVu0i+KrfUmIYMm3YFSpdySSOzawDDYkCiix7uSFlOu
         g6RQ==
X-Gm-Message-State: APjAAAV7+jXv14gsvyHS4zhpYBh27l5AM4tF8gNnCm4VgDP5v6qI9dU+
        fIMgJtML2eDQ/FeHeQYHaFwGQQ==
X-Google-Smtp-Source: APXvYqxxvv6MgQwEFKiPW11F4UgW39kHU4+vtSKEZwzdoPGE7A0tcn/bGW1bvAqKxvXleIvitu6yHg==
X-Received: by 2002:a24:360d:: with SMTP id l13mr116423itl.83.1553623060238;
        Tue, 26 Mar 2019 10:57:40 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 14sm8029382ity.24.2019.03.26.10.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:57:39 -0700 (PDT)
Subject: Re: [PATCH] loop: properly observe rotational flag of underlying
 device
To:     Benjamin Gordon <bmgordon@chromium.org>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190212225424.139232-1-bmgordon@chromium.org>
 <52a9cb46-5863-834c-3378-5b0ec87814e6@applied-asynchrony.com>
 <CADaYBq32aM4QpHmOmevFWSkjYqWmBWdhgd7CDWh+Se6q_2byHg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9d510d5-c301-f936-b5ab-812e64261ae7@kernel.dk>
Date:   Tue, 26 Mar 2019 11:57:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CADaYBq32aM4QpHmOmevFWSkjYqWmBWdhgd7CDWh+Se6q_2byHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/19 11:04 AM, Benjamin Gordon wrote:
> On Tue, Mar 26, 2019 at 10:55 AM Holger Hoffstätte <holger@applied-asynchrony.com <mailto:holger@applied-asynchrony.com>> wrote:
> 
> 
>     Ping! Jens, can we please let this finally land in 5.2?
> 
> 
> Yes, please!  I've just double-checked and this patch still applies cleanly.

I've added it for 5.2, thanks everyone.

-- 
Jens Axboe

