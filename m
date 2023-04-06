Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9EEC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjDFG4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjDFG4P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:56:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344DAAD06
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:55:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y35so23190503pgl.4
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680764116; x=1683356116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgWX2LrAR817rsfNCBcYRWrSNfY/y5Y07ReZvR2Mc/k=;
        b=oUXsqdh5nyF8duxkDSoDe7UKSSJj/gFgQxHf47YVnBiRO104uuaO8tpEumEBfi9Mt+
         E9CLaM0ZDlrKu7PYnJwk5nWP7GeGQd0aUixKtVtvwkoXGEPKTVa3uwawxQ30Z3HQD25K
         g7cDZk1T+Tbw8xIrEYL0C4ygL0/Ddp9buIbwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680764116; x=1683356116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgWX2LrAR817rsfNCBcYRWrSNfY/y5Y07ReZvR2Mc/k=;
        b=jz7gVLByztVurEB7p7IVaXKO8z4b1qcP2pvnm5UWuNTGfmgPxyNGTksnMMOHxtW+lL
         UOzVOst+YqPEAcBgQ5u1PpT+orekyGnM86drS9dQoXmjyAzQU9dSJqLUch87D4teKwF6
         +4zJjAGCzaLWXmRR6zzM09mSYuZir0D5w35VFjVrdbkxjYxQAwfmp8fy/OgxE0/Lii2k
         ff2dQ9kNeZiG7Q0ADy5VeglWCf2acs7/rebNJ4+6cuWxF/l7IifgUGiq6zG0kbc3C1n7
         L3iplaDPVe4ebPOV9XkK6jLZU+emEzqeIk0iPdThG/uWMIkZXOSpOS5pYi2cMxCCUf9p
         l4iA==
X-Gm-Message-State: AAQBX9fH2rW5xlZoiN+zRT0G9JtF254pL3dL3JNIK8rHgc9KZuEmyvzw
        eKNC6ohh71Fn+HFBsapP+aDl+g==
X-Google-Smtp-Source: AKy350a9oHhwWKrFHjzcKAfQwvf8FQL4BUCMDtDztD4QFQ9oXOUAUmuRm2RDGR9kuJC0PeUfbKiXXQ==
X-Received: by 2002:aa7:9590:0:b0:62d:af5a:27bf with SMTP id z16-20020aa79590000000b0062daf5a27bfmr7582713pfj.6.1680764115812;
        Wed, 05 Apr 2023 23:55:15 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b005a8db4e3ecesm544277pff.69.2023.04.05.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:55:15 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:55:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: zram I/O path cleanups and fixups
Message-ID: <20230406065512.GL10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the zram I/O path, and fixes the handling of
> synchronous I/O to the underlying device in the writeback_store
> function or for > 4K PAGE_SIZE systems.
> 
> The fixes are at the end, as I could not fully reason about them being
> safe before untangling the callchain.
> 
> This survives xfstests on two zram devices on x86, but I don't actually
> have a large PAGE_SIZE system to test that path on.

Christoph, if you'll do v2 please Cc Andrew on it.
