Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67C3C28CC3
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 02:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2CC2070D
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 02:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LdgWilgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFECnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:43:14 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36719 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFECnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 22:43:14 -0400
Received: by mail-pf1-f181.google.com with SMTP id u22so13926989pfm.3
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2019 19:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UfHXQBiKFf0VnjbmT9I3EtGC3ROj48d5mR8yYt5A/CI=;
        b=LdgWilgEaNBVV/nrTqzjyx98ZUfQsxu/jGQD7JqCdlbkLB8MW8axzn665bJ8C0Bzr4
         MlB20cqWrADI0W4PeX8BAhldFVKZDlT5gHeHf7GbqevJ8ToU8eMZplf2e2pRELv7q8YQ
         v3ZZAGph6uwvW9atX4CsidW8wmWff2PzX1a4zF/aVG2hyq2ZYo/c19kty1hI/fxGgNnT
         T3Yi7JJu+Q9DhvSi57Eo3JvlaZTSbV0b1ysOSuW7C1IuL0J4PssI2O05/l/i/IFqGdN8
         Um1CUESVLtsEs9PFbiAHxmIP3f5u8F6CHT6Ob98fLACmlrw/0l65tWWchtjll0X6vEax
         6EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UfHXQBiKFf0VnjbmT9I3EtGC3ROj48d5mR8yYt5A/CI=;
        b=i3dDDc5QKPbqLt4OPEvE/b/he2NzlGcZMn1bTmUkLlMWl0A7O6MVQF3NN28xfo/XYH
         afz/F8aGNKAKk+wfx7DrtXFVhTB7mLCVMbOc4UDfwFQdeTQV9MGq5mg/IOuQrFTKv4sp
         lzmGlJy5L694NR9oywLNjfhmY2t4aClx97oWT02qp1lbU67fh5Pu06smL6jm7zaUnZ/p
         0Wa/6d1shKciKWNN+mqMyIHnyHt3NFqdKUehSDJHrdIQWcuigZ13FSugJs6aGFk7Gfhl
         vkj3bZ3U1oaqC2Vtq+mTi6dCO2yvm+sUhD/z/n8+w6gK+o6gthON7xgnKUnSVjzItu5E
         MXVg==
X-Gm-Message-State: APjAAAVeau+MYuMgjn6RYKtMVkY98ys6jx9HEW25aPvqGO+gsSOgyv0i
        YM8n0kSpKrQ7mbBzN05ab3GeMLBDQZfAgg==
X-Google-Smtp-Source: APXvYqwZmAxYcr+L2I4TGQLKlSMJ15gVjLcoRoAN63BgiRt2oRkwHZVUOhZEhQ2q0RnKnAuOJ6l9ww==
X-Received: by 2002:a17:90a:fa12:: with SMTP id cm18mr11583796pjb.137.1559702592934;
        Tue, 04 Jun 2019 19:43:12 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id h18sm16546268pgv.38.2019.06.04.19.43.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 19:43:11 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: Vacation
Message-ID: <a2544ad2-bcff-ea97-7752-4e954f7a50a1@kernel.dk>
Date:   Tue, 4 Jun 2019 20:43:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Just a heads up that I'm heading out for 3 weeks. I'll still be
reachable on email and I'll collect reviewed patches and make sure they
are marshaled off properly, but not much activity beyond that. Except
response times to be slower than usual, I'll try and check in every day
though.

-- 
Jens Axboe

