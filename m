Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA7C4332F
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbiEQU7J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353164AbiEQU7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 16:59:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D25371E
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 13:58:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c10so505758edr.2
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJNZLXvniwh5rhRoMfxsg0LACZj75fWMWBcFFN9Ud7U=;
        b=jvPhqs610qrOEyE8f42MTnA4RzTw/Pt/Df2bbw/BFU+9CW6MqLgzQVLENRGW/J99+6
         LcaN49zv/QOUlpnrGUXB13f8h5VWwh1PC1caDhmmhEcaRLsLBRKIZ2KovBYmW72MxRqa
         HHZuQVwBgCQ8MUPGXFMcYrFb0IFC5Y9mYG0S9XBmegVQQ6uzQN+OMQPGiRPT121DrzrD
         VyzaPSwBecsyLVfmpWnSzLzysqW9sR3h2IL0Iai41NKLS5J9TUETOv3C46yYGtQJkjOh
         bgB/Oo68I2rP7tax9WZDwlpO4bEw+jgY/io04iBC5CpY9Rw2bYtbMdSzIIjkFwQRfB+y
         T+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJNZLXvniwh5rhRoMfxsg0LACZj75fWMWBcFFN9Ud7U=;
        b=eztrdGys+PgH4x4n53KxJROlyB8JsNX6bA4wtLoUO0pThK6woyF0c9PGKxFwmyoco+
         XNIxcyvo/D8DFhC+5zsEt8YYNFnJhwvD3bCshZ2fMsK/TdZkz6Oqz+H00WdmrsglIanO
         3IRUabCbvRPU/ead1hftLuCWc6bHdyIswxfJkqW8pl+SSKXilS0tVc0IfZvADrAGJOE/
         wHJczLC6YZs538En+XjZqRVfqjKC50K97P7o2bAKUzEHpce4mDdWflhZiD7A9oKZvBIu
         yebClNDLP44daL2yvNU5pkH1UxFuAzE2DdzgLlcxIFk5cpI6SvQGljDcX9VrOTBEP1pe
         yZnA==
X-Gm-Message-State: AOAM533jQCvgMede+DgJqBwczVlR66LUa/LO9Dvtqmqa0er4sx06UKxx
        a+hBp0YmSfbeiRWvE3GqIVA5yfvQaiNSlqHpJsssPg==
X-Google-Smtp-Source: ABdhPJyO965/kAFcmCyrfqOUnmxcE0pY92GCVjcVNdVFa0hROg67M/SxMUfL1A5S/FmX1edEAxbul1vHvxHhk3aTfHM=
X-Received: by 2002:a05:6402:28b2:b0:42a:e63d:880f with SMTP id
 eg50-20020a05640228b200b0042ae63d880fmr354880edb.279.1652821134203; Tue, 17
 May 2022 13:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-2-davidgow@google.com>
In-Reply-To: <20220513083212.3537869-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 17 May 2022 16:58:43 -0400
Message-ID: <CAFd5g44aUoZgXgyZQVdzQrfrH5fm2TCPxM3Wm+FmkfN5ky1g7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Taint the kernel when KUnit tests are run
To:     David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 13, 2022 at 4:32 AM David Gow <davidgow@google.com> wrote:
>
> Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
> Due to KUnit tests not being intended to run on production systems, and
> potentially causing problems (or security issues like leaking kernel
> addresses), the kernel's state should not be considered safe for
> production use after KUnit tests are run.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
