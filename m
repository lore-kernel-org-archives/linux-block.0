Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C4FC433F5
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiJFOpW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiJFOpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 10:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E839692F4C
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665067503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szsrOLyuanSQuhduXkmhJcDFcnP0SxPlfZGY4+fPa+0=;
        b=a1uQTtVXyaIQA5Br+Cf9mGG94DalyO711UskCiMy/8LSfDgqS/Q6bIi27y7x6XpWDuoQFc
        lthhuNUmVZTTf0D4MbnW2QoxbB48xT6tvr1M5HMy95tMGrGCPzyeznsyN/+zdRTw87mvAC
        /ERKfBvzKNLhbNn22KlM5nIVSCvg2Ko=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-FWJljyk8O8GaAqXDBCsSow-1; Thu, 06 Oct 2022 10:45:02 -0400
X-MC-Unique: FWJljyk8O8GaAqXDBCsSow-1
Received: by mail-vs1-f70.google.com with SMTP id 65-20020a670344000000b0039b3020da1bso508775vsd.3
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 07:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szsrOLyuanSQuhduXkmhJcDFcnP0SxPlfZGY4+fPa+0=;
        b=5CgPG7bVpN0DI4XQJqPLkCHDPRmi4DZ2tihzJi8BC6HZdDLZnFONqRxdN+xX1rkV2L
         0Djb6/kGbaP1FidgBAq0Gvlf4Lt0ZylIJaE0IQEqZJkzArVKef5zVEsnxG/97HK5B9He
         UKUytq1fHGKIW1tRxqCY/S71V23sYWgGBuvH1r+BXEtkDDiXumxnKUhwKKXS9R7QSsxl
         YnrpZyrJ7AbrUGsiGw2MlqHh2ZXoqRIzjZcQiI+h/1jc3FmAu1UB0KIai2Oxaio6HN9m
         kaCHhZNT/lWw9oJ555mY1zZkUc73lPhEAqzCHOM8PYGz4pZrEjY1b8YgHxwY793aMn5z
         +DKg==
X-Gm-Message-State: ACrzQf00Nltu1LwAfMtr0ZVzsaN/tgQ1920JaPBQ7fBm2gtOcyX2pAEj
        ahUwMP3U/px2B+efBjZtQUh2IHSME501oiNikvDZ2trxiXFGD5c0BSHuy54orX8a7cC57zrR5E3
        awbbtqUzw0a1Hmik0An+EMs4dkhiSlAZzs8eVH/M=
X-Received: by 2002:a67:d201:0:b0:3a6:804d:55ba with SMTP id y1-20020a67d201000000b003a6804d55bamr2613119vsi.35.1665067502094;
        Thu, 06 Oct 2022 07:45:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Eq3/pF3bVaTO4jRXaS5/AAbLhoATZ2EBtZnuGGJVs2kF8jeRYioWORbZ8Aw1aMiHg1xkDWYXijZXm/UKaxDg=
X-Received: by 2002:a67:d201:0:b0:3a6:804d:55ba with SMTP id
 y1-20020a67d201000000b003a6804d55bamr2613113vsi.35.1665067501928; Thu, 06 Oct
 2022 07:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
 <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org> <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
In-Reply-To: <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 6 Oct 2022 22:44:51 +0800
Message-ID: <CAFj5m9LSw+1g1j8ofEQhj6GFJX_pWRNGqbTzNNNfE3RnWcbdHA@mail.gmail.com>
Subject: Re: again? - Write I/O queue hangup at random on recent Linus' kernels
To:     Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 6, 2022 at 8:37 PM Jaroslav Pulchart
<jaroslav.pulchart@gooddata.com> wrote:
>
> Hello,
>
> I apply the
> echo 0 > /sys/block/vdc/queue/wbt_lat_usec
> at the production servers. I expect it will disable wbt. Could you
> please confirm that my expectation is correct?
>
> The issue is happening once per ~14-30d after some random higher IOps
> (~25-100k) peak so we need to wait....

Next time when it is triggered, please collect blk-mq debugfs log via
the following
command after the hang is triggered

(cd /sys/kernel/debug/block/vdc && find . -type f -exec grep -aH . {} \;)

Also you can try all kinds of settings, such as reducing the
nr_tags/queue_depth to 4 or
smaller(1), for quick reproduction.

~14-30d is  too long to verify any change.

Thanks,

