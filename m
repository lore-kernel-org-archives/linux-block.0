Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28644CA0EC3
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 23:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjIKXRC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378468AbjIKWcr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 18:32:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66D40F7E
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 15:20:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-273b1ea30beso1142854a91.1
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694470756; x=1695075556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiUitO1C45IpsjxwGwdvQemaaRHBGSkxcQvlW7NOoGw=;
        b=GjXo/kQGb8J4cEDaGVKo1jENgkTFL/SZ2HSgWOfXnR66nKJWBE/ZSeoeOX12eYqeFC
         sIOptF6wMtujaZvA4Uxce09AUQTt9RQ98+zXtN9mO6OBjfJu7NSOBN4/msdN0G5K50Gj
         9orICPPg/jGJNw3Wyt0It9EQJa8YAzVEJtdbJAcA50JZeOYEH1sOIXnEI/BGfky0qV3O
         Sb7wzfpbwdqELK4juikIOZvaZPL7ordubUQBeWZkKes+v+nxHDDngWY0H1TILCYzmtmN
         dnlle1CqTP4nJ6pOw+hkrxdHKiNZLOFLr6LwbLAC8lE8edqrLdBWG2W8j1l3DhFgu8Pa
         ZOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694470756; x=1695075556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiUitO1C45IpsjxwGwdvQemaaRHBGSkxcQvlW7NOoGw=;
        b=XtqOz+vqGFOFkBcwhVSeX/1S6fZRxaKoXnbzy5+3HJKPtV6dZLZt0t9RySL1ee1WVs
         uUJpuPhHsTJBIg6TE4N09qkTbB7/RFpPGgPvmt6M4BwRIWiz7QSVVbKeQu727S9Jz+oi
         NSFec53mYBMjJ4DSoFiN4M8zzFKwzlktUfIjmdE1yRM8p9cK6bvf2aiXmJB0CKs7Casy
         x+agMHx2AZGjX5QLhnguH/nYk8w691/Amk4/+UlVpL7A8A6fUrr1wXkFyzeKI5iTCtA1
         dn1Vzt5j0GUeV0jtW9E8RXSbl07cOeHJTzIJGR9+SgQgqLnC4xzLlyghH03iw87UncUr
         W6Lg==
X-Gm-Message-State: AOJu0YxzgLNI4CjWtHwTHe2V4WOF+ZNSpIsfWHKE8YdydpDruIpV/L6v
        4OOZl+Trx0i1EUYbowSh7hBWpg==
X-Google-Smtp-Source: AGHT+IEIG7J/4uQXyapv3ec696MJuuJpu5Z5SUZiYUFG6GJOQa+L0fXAy+FH7WO2a2Nx/sq9gGkHJA==
X-Received: by 2002:a17:90a:3ea5:b0:268:ca63:e412 with SMTP id k34-20020a17090a3ea500b00268ca63e412mr10497992pjc.4.1694470755891;
        Mon, 11 Sep 2023 15:19:15 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b00268032f6a64sm7850906pjb.25.2023.09.11.15.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 15:19:15 -0700 (PDT)
Message-ID: <1a8f8c46-a048-4bd7-90f1-e5378b81968b@kernel.dk>
Date:   Mon, 11 Sep 2023 16:19:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3 RESEND] generic and PowerPC SED Opal keystore
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org,
        jarkko@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        keyrings@vger.kernel.org
References: <20230908153056.3503975-1-gjoyce@linux.vnet.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230908153056.3503975-1-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/23 9:30 AM, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> This patchset extends the capabilites incorporated into for-6.6/block
> (https://git.kernel.dk/cgit/linux/commit/?h=for-6.6/block&id=3bfeb61256643281ac4be5b8a57e9d9da3db4335) by allowing the SED Opal key to be seeded into
> the keyring from a secure permanent keystore.
> 
> It has gone through numerous rounds of review and all comments/suggetions
> have been addressed. The reviews have covered all relevant areas including
> reviews by block and keyring developers as well as the SED Opal
> maintainer. The last patchset submission has not solicited any responses
> in the six weeks since it was last distributed. The changes are
> generally useful and ready for inclusion.
> 
> TCG SED Opal is a specification from The Trusted Computing Group
> that allows self encrypting storage devices (SED) to be locked at
> power on and require an authentication key to unlock the drive.
> 
> Generic functions have been defined for accessing SED Opal keys.
> The generic functions are defined as weak so that they may be superseded
> by keystore specific versions.
> 
> PowerPC/pseries versions of these functions provide read/write access
> to SED Opal keys in the PLPKS keystore.
> 
> The SED block driver has been modified to read the SED Opal
> keystore to populate a key in the SED Opal keyring. Changes to the
> SED Opal key will be written to the SED Opal keystore.

Applied for 6.7, thanks.

-- 
Jens Axboe


