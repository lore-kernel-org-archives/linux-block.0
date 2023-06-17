Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B5DEB64D9
	for <linux-block@archiver.kernel.org>; Sat, 17 Jun 2023 09:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjFQJkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jun 2023 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjFQJkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jun 2023 05:40:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF519B5
        for <linux-block@vger.kernel.org>; Sat, 17 Jun 2023 02:40:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so1378419f8f.0
        for <linux-block@vger.kernel.org>; Sat, 17 Jun 2023 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686994829; x=1689586829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSprmwV55BL6pO21twlGThyVNNCHtDq+U6HFFLynfeU=;
        b=QvopeLhwKs03MqbVjzfgMBgUpb3MFQWLcXeEkgVOfBW2OjBGU7figSHWDe/7KSVC59
         uUh2CmgsfwfqFZRhN4x8MJlEZ1JY3sOT3N2tGx2ld14fMVG80JHEb3+Xl0ONlf0r0AwQ
         x6SZuzTj3FbVxiEPQinqvPDdUQ/6t7fIC3T7hN7zR/FEwpnMuyEIDIQJ1476sLISoNtg
         EDZHjCy8sTox1N9+O/yDDX/bHW6VVVtsac8HvtW4p6NlKGiojL50yQUcc3ovWqu9A0/r
         bdmmpzoA5WUSpYaq4VGnRJjPJdp05L/+KGm8hhFpb6hKccusnlfsaAzaj4hal3jXHL9H
         xdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686994829; x=1689586829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSprmwV55BL6pO21twlGThyVNNCHtDq+U6HFFLynfeU=;
        b=G7F8mNUK4JCeYFaZFKOFyxqa4a4FGdiDgG76Aoi9rsr+CU5GidgpBreJBWoBOSseQX
         9LQi/Flx88AsiTowKnMhWaxehfTfL1AQI5DvcJDc2EXolu/dMWbZsOh/KQzLmLM2LZNn
         CffpM3Us2rUgYcbdGcZHrlPsgba0DKyBF8UjYnpODoeA6COwXyhB/vzQfQmUsk2OExvy
         X9D4vkzXdWIuzvT/Dl8hr5erHKsepdon3dptgRSP1AKhHdHLSbI0vMEm4iC664H4wtAz
         cn6GwLCD21SLRxi3aZnWFnwb6YLXYt3UiWh/sS2DAHdyiLc5En1i1qV0fL6INgaXNxLc
         vyhw==
X-Gm-Message-State: AC+VfDziGWlhmFoydXosj4aWDM86WJkdMO88C487ejZCOqBs/gTcxF7o
        HvpFgGUPgu+z7Y9++kckPiuiB9/scpFUyvqn7vRJyQ==
X-Google-Smtp-Source: ACHHUZ48RfrAu3uWhShOXGuryhBPWKmeDCU6Sa6NwRJUaUbJQztOBoeMXM5rF7rzk+LforIRXtB6Sg==
X-Received: by 2002:adf:fc4c:0:b0:30a:e69d:721e with SMTP id e12-20020adffc4c000000b0030ae69d721emr2656000wrs.55.1686994829244;
        Sat, 17 Jun 2023 02:40:29 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b0030fa3567541sm22690907wro.48.2023.06.17.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 02:40:28 -0700 (PDT)
Date:   Sat, 17 Jun 2023 10:40:27 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, jordyzomer@google.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <ZI1/i3E20Wysp//g@equinox>
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
 <20230615163125.td3aodpfwth5n4mc@desk>
 <ZIufZn+reW0rza1H@equinox>
 <20230616031447.yslq6ep7lxe6sjv4@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616031447.yslq6ep7lxe6sjv4@desk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 08:14:47PM -0700, Pawan Gupta wrote:
> On Fri, Jun 16, 2023 at 12:31:50AM +0100, Phillip Potter wrote:
> > I've now looked at this. It is possible for cdi->capacity to be > 1, as
> > it is set via get_capabilities() -> cdrom_number_of_slots(), if the
> > device is an individual or cartridge changer.
> 
> Ohk. Is there an upper limit to cdi->capacity? If not, we are left with
> barrier_nospec().
> 

No, from the perspective of the codebase, this value is read from the
device and is therefore arbitrary in theory.

> > Therefore, I think using CDI_MAX_CAPACITY of 1 is not the correct
> > approach. Jordy's V2 patch is fine therefore, but perhaps using
> > array_index_nospec() with cdi->capacity is still better than a
> > do/while loop from a performance perspective, given it would be cached
> > etc. at that point, so possibly quicker. Thoughts? (I'm no expert on
> > spectre-v1 I'll admit).
> 
> array_index_nospec() can only clip the arg correctly if the upper bound
> is correct. Problem with array_index_nospec(arg, cdi->capacity) is
> cdi->capacity is not a constant, so it suffers from the same problem as
> arg i.e. cdi->capacity could also be speculated. Although having to
> control 2 loads makes the attack difficult, but does not rules out
> completely.
> 
> barrier_nospec() makes the CPU wait for all previous loads to retire
> before executing following instructions speculatively. This causes the
> conditional branch to resolve correctly. I hope this does not fall into
> a hotpath.

Thanks for the explanation. Based on this and the fact that particular
ioctl function isn't likely on a hugely hot path for most users, I have
approved the patch via another e-mail.

Regards,
Phil
