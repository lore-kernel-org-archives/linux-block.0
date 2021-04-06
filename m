Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1955AC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC8E613C4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbhDFI1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbhDFI1A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:27:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5842C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:26:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z1so15476377edb.8
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+YO6XjuIX7Kv+0VLCRZkMz5dwtdex1hH9l3QSvw2eg=;
        b=JorbyKh/vL89jIrvyk1DjzgaEH6tY15q3KI1LcBdRXDJVGUiZzJmrAiquoaRSBqj7d
         K9AQqk4K+olw+6hGgn0dqVu+H1ukWEtpfH8DkPvywIy4fUzYlE+6Ip9QQ9eajPto2Maf
         3RAfVgttTtgSoC13oNcYf6M1S6PLnq+Hfdg2Ne/vqE0oFtCe0jDZJSCYM4Nl+XfDjXjN
         YjC20tZfthTtPKjaomvGkKwH6HIbk+1GewTr0y+5mnaxGqTJikzo6IojLn+NeSzPE0BI
         1vXeJpFMd3R8oC+Q0X/DzRWTZv6NNQlRMHJwcWMpFybWNVsHORZLvI3/brAVhyNNLGYo
         qMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+YO6XjuIX7Kv+0VLCRZkMz5dwtdex1hH9l3QSvw2eg=;
        b=ktY2T0eHdGBUTQ9QsdMiaJNvd8ABsaEkrR9KSqdWKk94O/WGqBuwhUCIcYET3Nyf4m
         rJsjo5Zpv6dkYB8nssPD0xfXE1tYQw6TJM4uOz77pCG5NsZ6uAvb+6zDTlju1sAicG8d
         rNHtFw9hz89wok5OB0TtHNYyz/BXoORdlbPHr1sjXtJsluXxc5HdUtTPclhDqjeO/jZP
         Hj+8RNQM4ASb4W8XbbPElttloEr6gIre0N7Sstgis4Ls3SIRk5IQskHTGuzOB20tt8lz
         XW9NCJj+EMqUCwbNg/gEf4lNlrdC0nyaq287hLqI2YYURjbl9z7efxjHdBGudtgPGRus
         O3eg==
X-Gm-Message-State: AOAM531x+AL4bmnIf52jHbpv9R3z4Nofu82kgPoJSjP7uI+XtspvdSaG
        sJ3dP0nhjFVhbeDRsiqExMJiXZlL1D35WYgXqrZ5Kx3a4WSrL3Bc
X-Google-Smtp-Source: ABdhPJzcdq+MXdWzEomn1y+zHkTRr48+bysYFdVM7OSTRlkzSFjHUPu98hL81mvJ/b47rkC93PcA0bFwYZoZCa/yFIU=
X-Received: by 2002:a05:6402:42d3:: with SMTP id i19mr36389361edc.220.1617697611363;
 Tue, 06 Apr 2021 01:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-20-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-20-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:26:15 +0200
Message-ID: <CAJX1YtbXoj6gbQ2RTjQciAu_-4E=9PvqBgCQ-X9NqyKW_Y_+KA@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 19/19] block/rnbd: Use strscpy instead of strlcpy
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>
>
> During checkpatch analyzing the following warning message was found:
>   WARNING:STRLCPY: Prefer strscpy over strlcpy - see:
>   https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Fix it by using strscpy calls instead of strlcpy.
>
> Signed-off-by: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
