Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF4FC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358E72081C
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V17+lfAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfD3QEJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:04:09 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:37444 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3QEJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:04:09 -0400
Received: by mail-qt1-f171.google.com with SMTP id e2so16046199qtb.4
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7C/H9ZzSU0qP8UYq2NJoxOTSjxthMtozx8jthqagPTo=;
        b=V17+lfAqUPk01IFJXUO56hClBUX2HDbxSbQULpTYSKkdi7HyAd33jfH5SIR8cXdcvE
         hw/F9aMeFlPeuK5f4rBww/6N/Xmuv3823rpt63eVEiC0Qan/UjihZuDkm9RygVdZFQS+
         uDXcBV7siz7kiet+/qLVaIcLptgJ9iivk9KSHlfQPKEm/K6sK09PpdfaQ642KUtpoLIG
         Ei/9gzhfAHqdmqH0fjfZyrt7AVGrIzU5C9CHggarLYx36WwDp5F8075K02Wntqlwb84c
         HpvByXvkJ7w/RAav80V4R5dscpV10nEf8hg1TH2pyWT4QZjAgYqwSCLSFK5QFiXIrs9J
         nWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7C/H9ZzSU0qP8UYq2NJoxOTSjxthMtozx8jthqagPTo=;
        b=FPs732XmIpGx9KV0xqgtaqIJMgubFJKZOpxkwMXtQfcQg+hVwgniAYkQrH7ZMMsfXu
         +vwXSseN7Wjru5Axzhu35Zgfh+FEuJzOP+ArC7mWeB++p1Pbx4vt+atmptIalO8tsQaG
         rzsAhaeDcjEFJ5+rfRuE/e4nubI6G673UgKOSRwcTS2DUOqM40Otti4UsKEpM6Hkz9rm
         JrnBmtSrfOAoYubjM0PW0V4vnccuoyDwgV3jz/uhNnZa/AQOhit835kESZmwWJYJzSos
         aisRHKNmhgmZcHOLQUzkzaoPgwF/r0DQ1ExgQUeHPSMfGg7zHH0hmxsumN3fsW6nO5yj
         ArnQ==
X-Gm-Message-State: APjAAAWLcHGMj3a3AOETT13emh+9RvZJOsXB2wOlhMz1xJjEVHLz+Fto
        sRPmkmGMRnBHUIFBmMissZzJNiYagiduEcgh4tRe
X-Google-Smtp-Source: APXvYqwcvQfk6RKX1YA+CEknGA6KPVffr8HcdjX65JCcNo0SBSztv0+v1lrmNaDd0LojAXwHvRQTc8ngINVBxL3bMxI=
X-Received: by 2002:a0c:ae17:: with SMTP id y23mr31197725qvc.199.1556640247675;
 Tue, 30 Apr 2019 09:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190425200012.GA6391@redhat.com> <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
 <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz> <yq1v9yx2inc.fsf@oracle.com>
 <1556537518.3119.6.camel@HansenPartnership.com> <yq1zho911sg.fsf@oracle.com>
In-Reply-To: <yq1zho911sg.fsf@oracle.com>
From:   Jonathan Adams <jwadams@google.com>
Date:   Tue, 30 Apr 2019 12:03:31 -0400
Message-ID: <CA+VK+GP2R=6+GQJHX9+d6jnMWgK8i1_H5FiHdeUe3CGZZ5-86g@mail.gmail.com>
Subject: Re: [Lsf] [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller ?
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        lsf@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 29, 2019 at 7:36 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> James,
>
> > Next year, simply expand the blurb to "sponsors, partners and
> > attendees" to make it more clear ... or better yet separate them so
> > people can opt out of partner spam and still be on the attendee list.
>
> We already made a note that we need an "opt-in to be on the attendee
> list" as part of the registration process next year. That's how other
> conferences go about it...

But there was an explicit checkbox to being on the attendance list in
the registration form, on the second page:

By submitting this registration you consent to The Linux=E2=80=99s
Foundation=E2=80=99s communication with you with respect to the event or
services to which this registration pertains.
* The Linux Foundation Communications ...
* Sponsor Communications    ...
* Attendee Directory
     By checking here, you opt-in to being listed in the event=E2=80=99s
online attendee directory. Some of your registration data will be made
available to other event attendees in the directory (name, title,
company name only)

Why isn't that sufficient?

Cheers,
- jonathan
