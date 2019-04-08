Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7877AC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 12:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46753214D8
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 12:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ZUeT6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDHMkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:40:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44378 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfDHMkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 08:40:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so11795275otl.11
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YJIdxlH7ZTRFYOdwbW7xwrxbT2j88sYE2As7pmruG30=;
        b=e6ZUeT6SJR+7ZszUgDdVIzzwoHgMOKjP39/hEgVp7RR2MEfgKUCW1Vdh+VLndEsDJQ
         DU3M2S+zQqmftmHxxSVsv/Vlw2oYvjv9vPNBM4kVzVFMa+aQyEGpDIpnBeq9UfHG0ZHd
         uU+4yH2Yrg0ew50pNitGEQxL4co4KGxhTh1+MUelkr25Bf8aMV1LgZ+wD8KwEzJ3GHNJ
         BTlg3wWpi06YF0/2XL5xB1zz9x7+CPbPmhkAAlKYydeLTQOXerItamrujF9XBrJLlYL6
         oyTHvAvUs2xM7GM2H5kVKlHLDa5GbzTM5DIGPsTkJiva6VPk+OSj/3rVgHR1vJyhQfB/
         Zbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YJIdxlH7ZTRFYOdwbW7xwrxbT2j88sYE2As7pmruG30=;
        b=ROijoMIHjdwZl/jdLXlkbu//LJJINm+0I1ytiH6UROPoMvh9Tij/RUBnreWpISgDFm
         WvVHI/l+C5+7o8qHxSys6z3WhSBePtPUqiAq/U6t1NQkVo8wECee4jNmM+1AJg8tv0g9
         siBnGqQ+YcVFm9do/Cikf9ly/gMNXFJ5S4TeoDvxqYLstWwgz+KaMtZKjHHJUonjSWdS
         gr4DHYMw0vp6qvTcVHEDAmVrBT5ZV++d/rPa0FPlH0z6hPARZoppP5j5J4DkaikmbSlz
         IpfS8lkMg7VhBMWn6fYwqmSdT2xnejW00f5sWwWiIaISPg3ZAPRq3GZ8z+yExyJ9fnGz
         VCyQ==
X-Gm-Message-State: APjAAAUH9nyb1StRA1zCtXKoiyBtx1NGOXtMWBlhI0iyjKd8q8ZLg49m
        HgGOCNJgnkdYrcMLydfjtP9T9j5ALX79QGbAZ4jW240=
X-Google-Smtp-Source: APXvYqwbXQbMT+BadjOqVrdEb801g8PxSamm0A/vW5DLdljmWWw0nVQU8QPPet9VOqnAMp846FHC9H1E4svWmG4fv2I=
X-Received: by 2002:a9d:5917:: with SMTP id t23mr20015157oth.102.1554727252337;
 Mon, 08 Apr 2019 05:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHG43Mun738NtLTQ4ASp81jVF+f6PzNhjvucGv8Dz1DTUDVHVA@mail.gmail.com>
In-Reply-To: <CAHG43Mun738NtLTQ4ASp81jVF+f6PzNhjvucGv8Dz1DTUDVHVA@mail.gmail.com>
From:   Pacho Ramos <pachoramos@gmail.com>
Date:   Mon, 8 Apr 2019 14:40:41 +0200
Message-ID: <CAHG43Mtboi-DNEs-1shodaU-ds0ip+Z8eGirQtC7ncv5OR4t-g@mail.gmail.com>
Subject: Fwd: About BFQ interaction with git filter-branch
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Resending as text plain as it seems HTML is tagged as SPAM, sorry for
the noise)

---------- Forwarded message ---------
De: Pacho Ramos <pachoramos@gmail.com>
Date: lun., 8 abr. 2019 a las 14:38
Subject: About BFQ interaction with git filter-branch
To: Paolo VALENTE <paolo.valente@unimore.it>
Cc: <bfq-iosched@googlegroups.com>, <linux-block@vger.kernel.org>


I wanted to simply give you thanks to you and BFQ team. It's the only
scheduler allowing me to be able to work with my computer even running
 git filter-branch --force --tree-filter... at the same time.

And that huge difference is with a SSD disk, even if some people in
internet suggest that noop or mq-deadline would perform better for
them. Maybe for throughput it could perform a bit worse... I don't
know, but for being able to work with the system and not simply need
to move to other computer to work, BFQ clearly wins.

Thanks for your work, hopefully it will be chosen by default for not
needing to play with udev rules or echo ... >

Maybe you could try to add this test with git filter-branch to your
benchmarks. In my case I have tested with: none, mq-deadline
(kernel-5.0.7) , deadline, cfq, noop (kernel 4.19.32) on a Gentoo
Linux system running their gentoo-sources kernel (mostly vanilla
kernel) while trying to work with a Gnome 3.24 desktop, Chrome,
terminal...

The harddisk is SanDisk X400 2.5 7MM 512GB (X4152012) and cpu is
Intel(R) Core(TM) i5-6600 CPU @ 3.30GHz

Best regards!
