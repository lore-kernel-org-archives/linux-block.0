Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E7C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjDFGvT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjDFGvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:51:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCED8A75
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:51:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f22so32569199plr.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680763876; x=1683355876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHHOuamO4teEC004v/Zi3aa5OQvfShhvXcFKt2axF2E=;
        b=Hv/T7mVim8ImL1G7C80SfzKn+E5yFnWJZxh5KveaUY47Vcoh4WhqFRVUcA26JKZeoN
         /1s9jAitDHIzUIKhU2YkfiTjzet6ZEm3TAtA9lbZUX84qoQw9XP3xB8z3o9qsJh0HgYJ
         zGEz8YpWMju82tWo9URe9/ucXMy7z16Asw9vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763876; x=1683355876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHHOuamO4teEC004v/Zi3aa5OQvfShhvXcFKt2axF2E=;
        b=2IcrNwDQKk79PW6vw1i4Eut2ZNBOT5mtMlve/qu6KhoEDcpl0m1IQGifjuTM+TnyFG
         v3n8AAAWtYOtzRhCxDGeDpYqlCCQPLtDJ0155AVbn4IisWubL+nv8B671ND3NTMjqwxx
         vjWh3gl4mw59ZAUoNk28BlMAIVKFAnW4JO1sN3WJUzX2p1yMC85VuX+o5v0A+qGQPP0C
         F1qyhL4EtT0bHJoTL47Cl+UTSQvfSDTm76kwIc8WTlIb6aE02Phfj5Rb9oCvLFOX2UO2
         9YfS/IqR22YMo13TMgNqMCSxRp465qsSR8VoMSP3ZbtBHo7O3WGmwrV+akxoOlIKE9T1
         Lfqg==
X-Gm-Message-State: AAQBX9ezHEoVMeKtGuSDyJ5ltQf7FV9ly5E/HNXpXq9UnrN5/+VJwv9g
        zY5TlQMGcz7plfsIXGTg8EwG7Q==
X-Google-Smtp-Source: AKy350YoyvqnqQsN/ekenQLyHTOH7bPk56AbIGH+EraGxIEt1bQiEaXa9inqqdpA+tDN/kaSS8uD+A==
X-Received: by 2002:a17:903:41ca:b0:19a:839f:435 with SMTP id u10-20020a17090341ca00b0019a839f0435mr5688220ple.3.1680763876286;
        Wed, 05 Apr 2023 23:51:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902758d00b001a076025715sm634785pll.117.2023.04.05.23.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:51:15 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:51:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: zram I/O path cleanups and fixups
Message-ID: <20230406065112.GK10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230406064325.GI10419@google.com>
 <20230406064601.GJ10419@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406064601.GJ10419@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/06 15:46), Sergey Senozhatsky wrote:
> On (23/04/06 15:43), Sergey Senozhatsky wrote:
> > On (23/04/04 17:05), Christoph Hellwig wrote:
> > > 
> > > I don't actually have a large PAGE_SIZE system to test that path on.
> > 
> > Likewise. Don't have a large PAGE_SIZE system, so tested on a 4k x86_64.
> 
> Hold on... Something isn't right with the writeback test. It doesn't
> look like reads of ZRAM_WB pages work.

False alarm, sorry for the noise!
