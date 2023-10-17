Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D9ACDB474
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 15:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjJQPYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344336AbjJQPYl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 11:24:41 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C26EB6
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 08:24:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a66555061eso4044339f.0
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697556278; x=1698161078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qh7Q8NUAv2rVsPdN7yhSbTMeWDBAoGpGghDSC62x+GQ=;
        b=2eO2kv2Zm9Zs6k+MPSts5JQH1UD5bRY3ScwgDVMW/tmDpPFMGZ5PGcAu4YSH91+JwZ
         VGZHoV9jigfvBbu5UwAb35wqhZR/d++NjFWCp6HTdGA6UErKl24YSQIYNDXs4qHB0PFC
         HqVtwhAH3f+Gl1UJ6k7yPU/U7zidyZvcGQstGmsTuC01+bhiPM+OuQEoAFJd+6Bs+i/m
         7UWIwg2KW25mec0V10AaawyTFHjxo3TO2CyR27i5BcvznF2x+abAp+FpzOfCZhDjsdWY
         mR+QjJL/U9UQtuZ881ul2U0DyHUmbHgvl/rwskDINRVRUZczVtCfD67ArkdWgTBdPBbo
         bSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556278; x=1698161078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh7Q8NUAv2rVsPdN7yhSbTMeWDBAoGpGghDSC62x+GQ=;
        b=aAD5IAYsT5EJoJG+GG9vr1nYCrdCTKDBA7O6fZPgVz0PoBPJWTLyljCQqg8a8kaFY0
         0/c/9GQOlsKZ3l47y06Cib9zBUV3J27wGNboyzDw/yWA8LJ+ruHeaMtqa7wt0W9XEFzM
         5lhzVUbuX1aZ2WyebggbJIy8lTYYpq1gNu5T4AO7lcR7JLTdhdjIT6gVU6oSg3Kkmz6B
         SwtqCcxGjv6nKbUF43FzIlxgrYvoJF/4jgKCm9aPANe9zs92Ic9y7+Qu+ovtrpn6s6oS
         0HZHfDpcwWtR2wnQwgSVNyQ3QEgH0z3ncn3q4JnHR+a+jKnT3V1jEo8jkPQeitdnPWs8
         aMzg==
X-Gm-Message-State: AOJu0YyzsA5sDB3+8jYHpGGuQRU4wu4tlXD0Sy5apoy+6cZ+MDfGwX2S
        QGVsPb30YEkONVcDyE6Y/u46LQ==
X-Google-Smtp-Source: AGHT+IFDsW8aivD+8dzqg0AXOBp975s0XTijDCNFV63puh5wNtaiHflHX1oTcEA2/GCt5AB8SnUOuw==
X-Received: by 2002:a05:6602:340f:b0:790:958e:a667 with SMTP id n15-20020a056602340f00b00790958ea667mr3377208ioz.2.1697556278674;
        Tue, 17 Oct 2023 08:24:38 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m8-20020a0566022ac800b0079f7734a77esm482778iov.35.2023.10.17.08.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:24:38 -0700 (PDT)
Message-ID: <c3e0e9dc-b4d5-4ccf-b647-61add2f6ec58@kernel.dk>
Date:   Tue, 17 Oct 2023 09:24:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] generic and PowerPC SED Opal keystore
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        ndesaulniers@google.com, nathan@kernel.org, jarkko@kernel.org,
        okozina@redhat.com
References: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
 <8fa5c9fdebd07f654c511d80d41a35817bdc3d4d.camel@linux.vnet.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8fa5c9fdebd07f654c511d80d41a35817bdc3d4d.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/23 9:09 AM, Greg Joyce wrote:
> 
> Hi Jens,
> 
> I've addressed all the comments/issues on v7 of the patchset and
> haven't received any feedback on v8. Is there anything else that you'd
> like to see before this can be included?

Let's give it another shot!

-- 
Jens Axboe


