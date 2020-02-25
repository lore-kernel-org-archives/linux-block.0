Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C51BC35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D916E22464
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T13AgVey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgBYUhl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:37:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45506 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgBYUhk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 15:37:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so759152otp.12;
        Tue, 25 Feb 2020 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCbOtZ15xQuIXsi/eFHFiZS0CcZ7vLne0v/3tqD0yao=;
        b=T13AgVeydbsga6v6DVD0Y4Bw6GVwrJA1DuhCi9PrMmmcWja2YeVmOhvvw/ffrmhQBU
         8Zmx1gl+QBq4Sn98QDSCNWrDagJ88Qz5zB90AQH7QaMwgrB50adxtfY38Fm4IJlKTVuq
         8RczIQlueqNsinaVlpYpUnQ53S41LkmFECja5+AM/fm8WMI8OPhpuVqEoAkInIQMcSsV
         cmLJQTOwnkJSp4YxiGGME8MHdF5N3KeYrmUVKYocYq0QJxxpKqPBa8zmzki90SjQelbE
         pYoL3Y8ScAqEzds/X7oed2ykPfd7WCTn5/armttgSQUqQSoRipUvQZmURlqwYOf+pLhn
         PQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCbOtZ15xQuIXsi/eFHFiZS0CcZ7vLne0v/3tqD0yao=;
        b=N15Mew0c5toCBkxb/FwM1jAPKMOKG1r59U8/Qmds1ehXCjv8UQ76i2wMUevQ/GGXMs
         V7yxLec304mbjPOzn7vQ5rfJ75b3WnZEUirnG/n4U13bi+2O6rpJbG9RyDlzgB8ORf7A
         j4EVlElkqC92MA7vTsuQKgduYF2LTnMe0BcpH8FPlw7t8rIe3o1r7q5uTMYAu0qDhC3w
         kJw0OlGnhkxzmTBvo+PnQ3sjCr+RILnggDB/LU+Qbre4PzSPVh/1h80kJyuyLyO/b4IH
         uFH6jDx2OdQ3UDOBOjDpZ6amMBaqoXlKBIq+k7Gn5WfJe2HJJo4Taj/0oeSAMXV/7q6c
         fAhw==
X-Gm-Message-State: APjAAAUTVtCpEoS9Bgkxhs5mhRE1rCxfzHP0xJhLdTMjAjZX/Kde70gQ
        P+Q80zkGUk18atgTRjORldG2j9TdZ8+Cdnp5uXfYk5AA
X-Google-Smtp-Source: APXvYqwvxkiHwOg1asDMUxgb4LtyfmUmP1DAZC1krO6OSv88b5pwt67XyL2rFPVpnGDeSylzyo8AI1275i9bguQJ9ww=
X-Received: by 2002:a9d:664a:: with SMTP id q10mr312446otm.298.1582663059013;
 Tue, 25 Feb 2020 12:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com> <CAM_iQpVegeSSWDWZTt4+ZT6qE3-AwsyHj7DAkFiFu8+8Hy-5jA@mail.gmail.com>
In-Reply-To: <CAM_iQpVegeSSWDWZTt4+ZT6qE3-AwsyHj7DAkFiFu8+8Hy-5jA@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 25 Feb 2020 12:37:24 -0800
Message-ID: <CAM_iQpUn9EpwrWAYKwoJDzS8eQm=XCrvGeC_HV2EiZ4cnvk7Ag@mail.gmail.com>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
To:     linux-block@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 18, 2020 at 10:40 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> Hi, Jens
>
>
> On Sun, Feb 2, 2020 at 9:37 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Currently, rasdaemon uses the existing tracepoint block_rq_complete
> > and filters out non-error cases in order to capture block disk errors.
> >
> > But there are a few problems with this approach:
> >
> > 1. Even kernel trace filter could do the filtering work, there is
> >    still some overhead after we enable this tracepoint.
> >
> > 2. The filter is merely based on errno, which does not align with kernel
> >    logic to check the errors for print_req_error().
> >
> > 3. block_rq_complete only provides dev major and minor to identify
> >    the block device, it is not convenient to use in user-space.
> >
> > So introduce a new tracepoint block_rq_error just for the error case
> > and provides the device name for convenience too. With this patch,
> > rasdaemon could switch to block_rq_error.
> >
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>
> Can you take this patch?

Any response?

Thanks.
