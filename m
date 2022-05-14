Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD27C433F5
	for <linux-block@archiver.kernel.org>; Sat, 14 May 2022 19:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiENTZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 May 2022 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiENTZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 May 2022 15:25:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA235861
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 12:25:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so21860075ejd.9
        for <linux-block@vger.kernel.org>; Sat, 14 May 2022 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODXxWmmCbDSJu9NbGvrzBEWYJrCam31kj3DAUIrULPw=;
        b=fydf+4K2rqGXwV3YKkzV4MrpkLE5d7dWboE2/FY3razdRSAu9OymabboDHlXrq3En1
         CKVAYd3Ge1g3CpmRjUTOyPrsGFCnR5uRzZM0s7UxpYrN5r+5syrchhLVkCq7ULNUXiFh
         +SpuwS9z6aRBLkqL/gh8bEA2aPSuf1GoXtcoezfrIt81w00+SWcuNjSY4wVPLW+aJpI1
         01/wqHa7zwDei+3LiIfINf7awqSMIFL5rgfkTks2tXIywZeimnBDmXTnh74sonfBcu1O
         dndLK8JkKX5yjd9ZHhIEpoQLGBlRp/l/raGZ+/ZkizKdTiT1EiMLAJEmxzk338hn/09o
         MxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODXxWmmCbDSJu9NbGvrzBEWYJrCam31kj3DAUIrULPw=;
        b=cc0Rku79GWNFoZ8tpUTX+hpDMzS6GmfAHPsn7weLL0qFbAmByR5bftVpQ+JJemKt7Z
         cRoFjqvSMkAy/NS1vFqmxYbX8WO5nt9hzZfHDa+r0bZ0VL/1qst2YUfvtrkCH5hRry3n
         chmJML7qcCfpsPKbf8Vli/d/bw0ZCsOaJyxjQOCGGVZjowjp6Mo3hO4prYZSJfVAezt7
         Q3ffMWEQZcDtqizWal6I3ctQU1/e7HllPcnITj1e5/r8trlIYyMJ2BS6XOSdlwNxt5dc
         VAj74DCs3BN2Um+h1oJtOUAe30lIkFHxmoLryWaxKB1tsqgAzYzmyMVVDt37GAr+rHl0
         EDUA==
X-Gm-Message-State: AOAM532Mkps44TctNDr35EE7bdhOD5/vmbF9YJteoyhRtQWRiXu8bQ3c
        OkfiPhlZrTrwLTxGekFGjWhPIe5ql3u7i5z0qCPo0A==
X-Google-Smtp-Source: ABdhPJyDXaJyFKNP0WsvC7wn818jvoG0MDOEUSzLY6ezaPoiApXLhg4SheqGpl5SEXAgmkc3ufxJfZGsLwE8pFf2jn8=
X-Received: by 2002:a17:907:72ce:b0:6f4:5a57:320c with SMTP id
 du14-20020a17090772ce00b006f45a57320cmr9176463ejc.75.1652556336145; Sat, 14
 May 2022 12:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-2-davidgow@google.com>
 <CAGS_qxr54nYThsj6UhqX54JO5WnyJXVQURnNF1eCzGB+4GCKLA@mail.gmail.com> <CABVgOS=gTznLFBTZbmNH7AFDnr7O70mWR9v4q6sDA7q04fKT=Q@mail.gmail.com>
In-Reply-To: <CABVgOS=gTznLFBTZbmNH7AFDnr7O70mWR9v4q6sDA7q04fKT=Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 14 May 2022 12:25:24 -0700
Message-ID: <CAGS_qxqFEcw=28FxbMMtEcjqcsgFHXV6Td+uTgDj32Z=PiQJkA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Taint the kernel when KUnit tests are run
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 13, 2022 at 8:04 PM David Gow <davidgow@google.com> wrote:
> Hmm... thinking about it, I think it might be worth not tainting if 0
> suites run, but tainting if 0 tests run.
>
> If we taint even if there are no suites present, that'll make things
> awkward for the "build KUnit in, but not any tests" case: the kernel
> would be tainted regardless. Given Android might be having the KUnit

Actually, this is what the code does right now. I was wrong.
If there are 0 suites => not tainted.
If there are 0 tests in the suites => tainted.

For kunit being built in, it first goes through this func
   206  static void kunit_exec_run_tests(struct suite_set *suite_set)
   207  {
   208          struct kunit_suite * const * const *suites;
   209
   210          kunit_print_tap_header(suite_set);
   211
   212          for (suites = suite_set->start; suites <
suite_set->end; suites++)
   213                  __kunit_test_suites_init(*suites);
   214  }

So for the "build KUnit in, but not any tests" case, you'll never
enter that for-loop.
Thus you'll never call __kunit_test_suites_init() => kunit_run_tests().

For module-based tests, we have the same behavior.
If there's 0 test suites, we never enter the second loop, so we never taint.
But if there's >0 suites, then we will, regardless of the # of test cases.

   570  int __kunit_test_suites_init(struct kunit_suite * const * const suites)
   571  {
   572          unsigned int i;
   573
   574          for (i = 0; suites[i] != NULL; i++) {
   575                  kunit_init_suite(suites[i]);
   576                  kunit_run_tests(suites[i]);
   577          }
   578          return 0;
   579  }

So this change should already work as intended.

> execution stuff built-in (but using modules for tests), it's probably
> worth not tainting there. (Though I think they have a separate way of
> disabling KUnit as well, so it's probably not a complete
> deal-breaker).
>
> The case of having suites but no tests should still taint the kernel,
> as suite_init functions could still run.

Yes, suite_init functions are the concern. I agree we should taint if
there are >0 suites but 0 test cases.

I don't think it's worth trying to be fancy and tainting iff there >0
test cases or a suite_init/exit function ran.

>
> Assuming that seems sensible, I'll send out a v4 with that changed.

Just to be clear: that shouldn't be necessary.

>
> > I wasn't quite sure where this applied, but I manually applied the changes here.
> > Without this patch, this command exits fine:
> > $ ./tools/testing/kunit/kunit.py run --kernel_args=panic_on_taint=0x40000
> >
> > With it, I get
> > [12:03:31] Kernel panic - not syncing: panic_on_taint set ...
> > [12:03:31] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N
>
> This is showing both 'G' and 'N' ('G' being the character for GPL --

I just somehow missed the fact there was an 'N' at the end there.
Thanks, I thought I was going crazy. I guess I was just going blind.


Daniel
