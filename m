Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC77CA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46A22080F
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 21:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="y0SFNXzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfJ3VS3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:18:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43041 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3VS3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 17:18:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so2341156pgh.10
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F9rEKqChTbsig5uqWsWqhjeCF1dSr2iagjzasllozQA=;
        b=y0SFNXzW6A0jELGwMNtJQnWX+5/43K/nZ1uMSVjLtDnFyO+Ad0zmm5XbYCpGVO2HIO
         pk5Zs4cFRb2r1MURlc+CsGMZNajX8yDIDu3evRa9nBmHpcWsuRZbkdatoO5GJujrgFaQ
         wDDhDWSktOMhlTJlFA7EM+4xmkJOh+yNsUoe6XmjvzeQeoVgHKUwA9RJNqApfbYCPgIt
         ykKNpIXGqF/2Ar+/u39QLlw2l3EG9P9PEUZvYoZLIlbpTkiaAUJTNJ8c3zaeHudNTqmr
         W88RvOi4Hb4NVyatFqhlYRZIbrBj3VpfCg/f/YI1IG052Dsn9LUIqOMSVQ1k9d8mcF7D
         j9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F9rEKqChTbsig5uqWsWqhjeCF1dSr2iagjzasllozQA=;
        b=Ce9D6VObhUAfvf7BSLffCOyDUa67ww4xDzXJMr0eko9LPF9CyjK5s08wd11yiqFopx
         tl171LlGH1RGXxjZsVrvyWElDpkXHZi6DJCGDzurKTW8X4xrBsFef4q4MujaXSQm+G2V
         WDC0cKBAkJaq/FGgX7fqcLNte0Tdk0/eMQ9x1uNXRdj0wslMHRfrt8sqOfJlOvzWUbD1
         F0Spemq+QIlYan3jhFhwKU3gVVGirHQpVJx+wUMbSo2gI7hnUMXNRtgOVWQDkWCBe0O9
         JFDEFPR1oPYiPCOqDBZGzxMrdYWNBuljkGx+8RiV6V3fivkbrDYHaK6tUfVAWIgK6OIN
         c3XA==
X-Gm-Message-State: APjAAAXPsm8irlrHGYPX4lvs+VBmXTJdb2JZYSx72BBpXbGfvXZQL6H3
        QKnnXAQUFlsMF1KjCo9yprDnvw==
X-Google-Smtp-Source: APXvYqyNwRKvmv5vzKqJtD/2YK1SsSOUbNtkutoxQUS86kxuF6I6xrGlzi7eVVdPW3d9jwN0aPj2HA==
X-Received: by 2002:a63:7448:: with SMTP id e8mr1781114pgn.268.1572470306579;
        Wed, 30 Oct 2019 14:18:26 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id l72sm4516071pjb.18.2019.10.30.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:18:26 -0700 (PDT)
Date:   Wed, 30 Oct 2019 14:18:25 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, kernel@collabora.com,
        krisman@collabora.com
Subject: Re: [PATCH blktests 0/3] Add --config argument for custom config
 filenames
Message-ID: <20191030211825.GC326591@vader>
References: <20191029200942.83044-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029200942.83044-1-andrealmeid@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 29, 2019 at 05:09:39PM -0300, André Almeida wrote:
> Instead of just using the default config file, one may also find useful to
> specify which configuration file would like to use without editing the config
> file, like this:
> 
> $ ./check --config=tests_nvme
> ...
> $ ./check -c tests_scsi
> 
> This pull request solves this. This change means to be optional, in the sense
> that the default behavior should not be modified and current setups will not be
> affect by this. To check if this is true, I have done the following test:
> 
> - Print the value of variables $DEVICE_ONLY, $QUICK_RUN, $TIMEOUT,
>   $RUN_ZONED_TESTS, $OUTPUT, $EXCLUDE
>   
> - Run with the following setups:
>     - with a config file in the dir
>     - without a config file in the dir
>     - configuring using command line arguments
> 
> With both original code and with my changes, I validated that the values
> remained the same. Then, I used the argument --config=test_config to check that
> the values of variables are indeed changing.
> 
> This patchset add this feature, update the docs and fix a minor issue with a
> command line argument. Also, I have changed "# shellcheck disable=SC1091" to
> "# shellcheck source=/dev/null", since it seems the proper way to disable this
> check according to shellcheck documentation[1].
> 
> Thanks,
> André
> 
> [1] https://github.com/koalaman/shellcheck/wiki/SC1090#exceptions
> 
> This patch is also avaible at GitHub:
> https://github.com/osandov/blktests/pull/56
> 
> André Almeida (3):
>   check: Add configuration file option
>   Documentation: Add information about `--config` argument
>   check: Make "device-only" option a valid option

Patches 2 and 3 look good (although a nitpick is that patch 3 could be
first since it's a bug fix that I could take independently of the other
patches). I had one comment on patch 1.

Thanks!
