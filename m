Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD79C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 10:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCBKfQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCBKfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 05:35:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75052DE6A
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 02:35:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r18so16044494wrx.1
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 02:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C52m1tVljJD1+vZ8f1h3Rfg+EcUxCxDMLMwQrEVeskg=;
        b=Y4uGA2YtfxC/k4u+qAD3ZoxcQBK4FrMcGo8flvdcH8rOao2YVEz+Cwg6D0vYcIJfzH
         GyC6r/kvfqUYWXNAn3c+En32gETcOv/1pqo7w9pysC6LjcOfkPtBW+QsbdEadZe2OUsw
         tV4XisRy7HsMC/O5VVRaUDeto5Ul5aV3FkU7k/xLMhtWlpiyPltMCNyDz/DXMOvDaoBQ
         2xAJFOK2e5Ru2Grpdf4wmjiufWmWYWMWeK+zATAmWyb7QBD7AWyaW1w2WHok8AyDruOK
         zc9SYdG110FZnQXTkJWXAme8hVl7LFAU3h8bdmqfqsctAykwLBSZJKa9myYvcKLZInLQ
         kdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C52m1tVljJD1+vZ8f1h3Rfg+EcUxCxDMLMwQrEVeskg=;
        b=bw0oIY5ASxFeLW7WH4NmgpUnJ37SpBXdEb5umpvFII+TZSiFal8SE1YUIjCuZUGphn
         qodhFCCSFwzpxuybh3IsnCaTcBH3WToSUWIoIOu9ZEPN6SAwR8jif5yPooZ4aNpgh0pe
         cJp15dRJK8gd7Kq+6CzmvSBwL8o/n1dEeNQeylmTwrFwdGOKlQrPRMzPiH6FSjbFFefF
         jVjmE/iqfyrAId7Mq89Ye33fFbe2dui1Asxfs4eUkImMcy6/xh6BERmeFemcW2ClCJqA
         +NfmjRhtE5FowLWTHwC7KUAtKCQc9VdFfNOLg52V4/iePS70DSK2gC46vtUV8+njrTW6
         NXkw==
X-Gm-Message-State: AO0yUKVJJ4U1ZBnpc963esVeOaYNPn59iWeUY+pQDJ62rWE8EI9Lrwnd
        Xn1Xo5TOgN5rLH2uRy35b50dUA==
X-Google-Smtp-Source: AK7set8TgU9pB6ImsSse7I0wmVLMeTLVWQIMctXtF6Tm7YmwMYVIjoe1hdG/Rszo0Ql6qKWL9efJUQ==
X-Received: by 2002:a5d:6084:0:b0:2ca:e856:5a4 with SMTP id w4-20020a5d6084000000b002cae85605a4mr1112818wrt.26.1677753312359;
        Thu, 02 Mar 2023 02:35:12 -0800 (PST)
Received: from localhost ([165.225.194.195])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d6a82000000b002c53cc7504csm15329231wru.78.2023.03.02.02.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:35:11 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590> <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590> <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Thu, 02 Mar 2023 11:07:15 +0100
In-reply-to: <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
Message-ID: <87h6v3l9up.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Mar 2, 2023 at 5:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>>
>> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
>> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
>> > >
>>
>> ...
>>
>> > >
>> > > I agree about fetching more zones. However, it is no good to fetch u=
p to
>> > > a max, since the requested zone report may less than max. I was
>> >
>> > Short read should always be supported, so the interface may need to
>> > return how many zones in single command, please refer to nvme_ns_repor=
t_zones().
>>
>> blk_zone is part of uapi, maybe the short read can be figured out by
>> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
>> reporting zones.
>
> oops, we have blk_zone_report data for reporting zones to userspace alrea=
dy,
> see blkdev_report_zones_ioctl(), then this way can be re-used for getting=
 zone
> report from ublk server too, right?

Yes that would be nice. But I did the report_zone command like a read
operation, so we are not currently copying any buffers to user space
when issuing the command, we just rely on the iod. I think it would be
better to use the start_sectors and nr_sectors of the iod instead. Then
we don't have to copy the blk_zone_report. What do you think?

BR Andreas
