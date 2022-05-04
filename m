Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D77C433FE
	for <linux-block@archiver.kernel.org>; Wed,  4 May 2022 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbiEDQ3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353538AbiEDQ3E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 12:29:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3321A1
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 09:25:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z2so2319567ejj.3
        for <linux-block@vger.kernel.org>; Wed, 04 May 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yl4WQenCDLJErgHp6t3UJjMlUc388BkN8ozV46DV1Jw=;
        b=UkruObD31qixCl3tEbnbC6/Szb3fOE20vobsG9EB3D9Txyb4DwrMg1MPuKOiuriQO0
         bfrFQY2q3GU5cpGZ7NEMVFeHonKS5jshPndb1NXSNCiTBMlfAEkFMO8MhdiXH6ubVy15
         BzqTQmHqpfWQzsfzfYtrrlft6mJ9zFxFJEfJ4U4Ie+qKpkI5l8BD5+La8b4QxtHnOZHv
         y9hlgtiUQDYw5ZGnGKioMzZ+lQRrGXXZhBVznZ74FaY+dTBY6b/TGGgYXY5R1PpQQCrK
         I9YG9e+4QLGYqahZJ2AFhjRAc1yU0adG166I7bIvuvzbKey6OlIqjHgUaeb4A8zObyB3
         Q+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yl4WQenCDLJErgHp6t3UJjMlUc388BkN8ozV46DV1Jw=;
        b=wI2tjQX36QOCsZ9AjHXdpjJfbC3XnanWd+XO15uBAS9PgR32JUYNma1j9NJBrlAihb
         pLtVKYbpEbX20TUwqirna6vMnaCLO1fOqPTX90P/CWZQhWE3AaiKXyhiV0/ogbp3hk8M
         1pGMnZ6bQarXll0eHoYnRjbPSTw4nP7AeCzI3jTrOS01NRUMVG06dvBYUoZvYCknp7dR
         jACu1rSPM8WjdGpZJGc/JkZYbx7xqkW2FakJxpqVOxNL4+x3xUMoT1ioKB3cUM8Y2A4w
         7q/ryvcvTmTlFzhnSmXOkSx6IbRKHKGpcCslQnLdaWzEj8zluh3Hkr4Ih07CA7FTm5z8
         4C4Q==
X-Gm-Message-State: AOAM532sFEhv8Jgd9W01ybVV289exN9R+VYGzvL8bFIHD1gIcjfPTiCY
        twCquu1Pb0sNL1GQxoVFQYnr7ykFzJEEdvpVOzRsHA==
X-Google-Smtp-Source: ABdhPJx2xz2gkiQHrChRkpvk1HKnyjR91ITm5VKWQSf9RezsTKQGBIkW/vQqKqLiPCJXMRXYwGVEze3ZiWHXru1KY2Q=
X-Received: by 2002:a17:906:a2c2:b0:6e7:efc2:17f2 with SMTP id
 by2-20020a170906a2c200b006e7efc217f2mr20140929ejb.542.1651681525279; Wed, 04
 May 2022 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org> <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
 <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com> <YnKS3MwNxvEi73OP@bombadil.infradead.org>
In-Reply-To: <YnKS3MwNxvEi73OP@bombadil.infradead.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 4 May 2022 11:25:14 -0500
Message-ID: <CAGS_qxrz1WoUd5oGa7p1-H2mQVbkRxSTEbqnCG=aBj=xnMu1zQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 4, 2022 at 9:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> selftests has modules, although I am not sure if there are selftests
> which do not load modules. Shuah?

I'm not Shuah, but there are indeed selftests that don't load modules.

I went looking for an example and found
tools/testing/selftests/bpf/test_doc_build.sh, which runs entirely in
userspace (basically just `make docs`).
