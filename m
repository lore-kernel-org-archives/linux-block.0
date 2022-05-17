Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3BC4332F
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 20:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352981AbiEQUpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbiEQUpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 16:45:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6882A52B2D
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 13:45:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so36917692eja.11
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSbaj6m8IruioDruqyoSFgzsLFTHdPcEb55nsCK4TWE=;
        b=gIJl50Eulc8Vsdg9AlkQITMqbdDAC+WLftF0jWbwTU2Ox6ZAesuN7rpCB0FMaRU0ku
         lJ4nDGxYlUcGBrMF0OBIcV7BVZ/6dQhxV8Y0AN9udmHCOs/hbsS8QNfTOzm42DOyD04B
         INwkuTN7sK2mchrwYyIFLcP6G7cfMdvJzdCsNO6DHF0vKZ31XkNnoK+uC/5SjLn6IjFW
         LYxNgm+TAwk3YHjlV0dMNF83/wQ0tz2C2XtfpIqEIso03Z3DCFpUgCW94yJNGTqJgJ1H
         adGsX1arLF1hk3vyAaddUCxOoag3FN3FPGl5vEZnxDkCBBx+fmhj7tk5jbSySPZDtWuo
         qm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSbaj6m8IruioDruqyoSFgzsLFTHdPcEb55nsCK4TWE=;
        b=6dw58csFARk1zuat74lwi4qlEdNYSpDgRiD3kACifiqYZLK1DJAGOTHWExrt/uFh8v
         6U9Yyts0IuKIL7aKOFDtgrrjoXDwilM3YXJdTPaGxkLteTF2ANTsFH1ePhqFMz+x5//P
         r7HeKscAq44GqVoBYRZEdvjTlIzXGdyFv4dNBXdWmZuCM5o3nlgvVq2Q5slQam1GY8cE
         snT0DQ3VxNRuCKJsvGPaP1StrdVqLNdf/wkY/zMsostYnL7MYofp/GADAdYle5AAOC1A
         Hg5d1OeL+0dNbGgQCHfAYgHAq3913WiXWtV1M64oTS1JWNkcEn3qwh01m5NpT4aQ6KxQ
         8sBg==
X-Gm-Message-State: AOAM532ViONh/kA5z0UX7BOcnalCPMpWyW8wvJmErriiPIvqJs5hyqy/
        3E52HW/Dlf5zR5xsacJv4B5hDjy9Sn1X4LXOrksavg==
X-Google-Smtp-Source: ABdhPJyUT7v/+bRMzp2NCjUfzxBgDqk4IrNgbSICl9zfGmBkyXaJdmW22wa6lYaF7OVZbcBIcBpg8Xk/VoVYzb5Je8E=
X-Received: by 2002:a17:907:1c89:b0:6f4:4089:8256 with SMTP id
 nb9-20020a1709071c8900b006f440898256mr20602107ejc.60.1652820311327; Tue, 17
 May 2022 13:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-1-davidgow@google.com>
In-Reply-To: <20220513083212.3537869-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 17 May 2022 16:45:00 -0400
Message-ID: <CAFd5g46dQ=q5UuXaoXwh32kjGoFi0m59L-frm6T5Xcwo81m0Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] panic: Taint kernel if tests are run
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
> Most in-kernel tests (such as KUnit tests) are not supposed to run on
> production systems: they may do deliberately illegal things to trigger
> errors, and have security implications (for example, KUnit assertions
> will often deliberately leak kernel addresses).
>
> Add a new taint type, TAINT_TEST to signal that a test has been run.
> This will be printed as 'N' (originally for kuNit, as every other
> sensible letter was taken.)
>
> This should discourage people from running these tests on production
> systems, and to make it easier to tell if tests have been run
> accidentally (by loading the wrong configuration, etc.)
>
> Signed-off-by: David Gow <davidgow@google.com>

Aside from Luis' comment (which I agree with), this looks good. I am
not an expert on the taint mechanism, but this seems pretty
straightforward.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
