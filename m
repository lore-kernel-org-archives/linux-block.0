Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E45EC61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 13:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBPNSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjBPNSO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 08:18:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791985F4E
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676553424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MdGJFHZv/2Zv+Ysvuyq4SlJgM+0STJ7hRrwb8iOEyeY=;
        b=BlU874d0bQMvCAQUosBeUKDOSaIWINO1uUxkN1vNpXIGFIwizELP9xPMtFF6AtbKpCpaAx
        9k6ZGAi8ocGA/XQCC2OXfH+2KAvNHLCGSdL9RTzeV+mkOpJhS/aqWC/ViCKFDRfOnKegbM
        dRzeI3hlx32B+2M8n6/MxB+5eJYAhP8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-253-S3QnbgsxOoeeBaD94lxjzg-1; Thu, 16 Feb 2023 08:17:02 -0500
X-MC-Unique: S3QnbgsxOoeeBaD94lxjzg-1
Received: by mail-pl1-f199.google.com with SMTP id jb7-20020a170903258700b0019af23e69dcso796538plb.19
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 05:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdGJFHZv/2Zv+Ysvuyq4SlJgM+0STJ7hRrwb8iOEyeY=;
        b=ebeKd0eCpfaQwdVIWC7P0TlOFkZsBm2cyscsPHq9nGCq0CKk9znlL7LXiTbpc4xwXK
         ZTvljKj+eof2eGnnpY3NQXv679zqQ6Rb4jUR7Eyl8S3lh2e1GpL/SNXbOQps9pxQZZvK
         GXkZxUY7aN6mFpmVXSLITezHxUXKO8hIgbXOWUUNsr8i0v3LFqLz1EPvbcV2UCCbZqQQ
         vtDWEiMmaGfsIv/P35LQ93eL/AjNwJOC744we36n7FYAp6gYu3H1ny/Fppn4Cty3TsU2
         MorlGWoNYo0egdkZCQ+MdYbUE7/N1VthPtVKYr/S7GJJkFeHHznCipd3kkHQDH+3dkal
         P3JA==
X-Gm-Message-State: AO0yUKUENyjN0ktS4nra6VaQD7qTTDQq4vZrD3P3vIUvvvQslxHogprO
        5TfFyMG+K7XMmA30O8I6a5WkIip2UaIbe0thY8rdqMMYkfaXdnaiYtA8vPg2hY03q/9pW7OQQet
        8J0ftH7oo4bMzVQPEHjBlNoq51Mva1OQXu8To5WMsrLUX59Vfjw==
X-Received: by 2002:a17:90b:17d2:b0:231:1364:4103 with SMTP id me18-20020a17090b17d200b0023113644103mr526607pjb.145.1676553421450;
        Thu, 16 Feb 2023 05:17:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8OW6dHAP0HJaL/mr5kVLmWOT0BI1KzJZKOvZNe90BHNqSv+r18CcHwXHwbOm0nzZ0urvOJTWjxQt6N+tVCw/4=
X-Received: by 2002:a17:90b:17d2:b0:231:1364:4103 with SMTP id
 me18-20020a17090b17d200b0023113644103mr526602pjb.145.1676553421197; Thu, 16
 Feb 2023 05:17:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs-jef8f4zxJQxjKirAWyZkTREycFdNPvQaGbgS-1r_Lcg@mail.gmail.com>
 <f4079ecb-f483-34f9-0074-b77a9bd36cb6@acm.org>
In-Reply-To: <f4079ecb-f483-34f9-0074-b77a9bd36cb6@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 16 Feb 2023 21:16:49 +0800
Message-ID: <CAHj4cs8WpKQbL-Yb3pRJk_n2B-QaTMmaCtBTcQGQYNnCWkan8g@mail.gmail.com>
Subject: Re: [bug report] WARNING at fs/proc/generic.c:376 proc_register+0x131/0x1c0
 observed with blktests scsi
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart
The original reproduced commit doesn't exists now, seems it was
changed due to the linux-block/for-next rebase.
I also tried the blktests scsi/ with the latest linux-block/for-next,
6.2.0-rc6 and 6.2.0-rc7 today, but with no luck to reproduce the issue
now

Thanks
Yi
On Wed, Feb 15, 2023 at 2:43 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/5/23 23:30, Yi Zhang wrote:
> > blktests scsi/ failed on the latest linux-block/for-next, pls help
> > check it, thanks.
>
> Please help with testing and/or reviewing the candidate fix that I
> posted
> (https://lore.kernel.org/linux-scsi/20230210205200.36973-1-bvanassche@acm.org/).
>
> Thanks,
>
> Bart.
>


-- 
Best Regards,
  Yi Zhang

