Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1759FCD6118
	for <linux-block@archiver.kernel.org>; Mon,  9 Oct 2023 17:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378011AbjJIRaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377978AbjJIRam (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2023 13:30:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CCFC6
        for <linux-block@vger.kernel.org>; Mon,  9 Oct 2023 10:30:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9338e4695so60707121fa.2
        for <linux-block@vger.kernel.org>; Mon, 09 Oct 2023 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696872635; x=1697477435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHSd56ONGtiYc/4iRkmyqmxuAngFJzU7FR00LimB0+s=;
        b=grFtVCa9AE5vZnIqHY2K2bNP8Z6TwHUlqSnlQynYLfm5yY9bfW+Udn2tegWIbDpqZV
         eIy68gqJd/Ry9v9XmIvfaKaBKzf/fJAMUDootzAKML2FCQG9tgQHF0skd2fI8KSZj4Zj
         5laR0MFZ2upzjp7XVdBB/uX+wUaNSql2ew7bKicL1rvMh4AiP1yQa7jS/aHH4SPCv+h7
         mJmiRaOLnWW7Fevap8tTGkZJxbnV/PQaBzkPAQA5vis85tB6Wt4vnGuO2FY3G3WXWPPQ
         5TGZ66RGIVBojnHk2wmoPN+YgNuIJfFDQYYSHN5NHspuLbK0Eb2LJ9kod7O3tg0yOsLb
         o0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872635; x=1697477435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHSd56ONGtiYc/4iRkmyqmxuAngFJzU7FR00LimB0+s=;
        b=HvAD9ngLecKB6dPD0pACh9tk3iKfeM3Bze5iRbbE2X8pLlGMyPcGRXcq/NB6vnJNCp
         csFtOf7ZMm//U2IDjXe7LatLfEOgmDgwAo/w5UMBj8o2Mi6ppLxYtucjWvT1Mt0Hzac/
         NK8h/ndD9UMdZVkY4Wlb5KRPA/1M7ZFJ68X9X0bG+PsrbgEMlOnwyrVTGDr2eD3nuRk1
         thJoWHpZLVAoDsUi1ilsw+y2iifiJLqf6cm937ysOIkFly35j7kcoFR++CmB/XpK37RK
         6h27rD3uT6fhgoDZdHnbsPqCxJJeI3ykjQgO8lK93SkXEgk+2W8t/OIi8ej83X7WGvrM
         KtxA==
X-Gm-Message-State: AOJu0YzykMPfk0uny9ziRj8dDMVNqA/wluenaXG5aK64UwCki+zHk5tY
        Ok7PbfFCBXrx0o4lJPjY1nLYy+85qJTNHsO+IbXPRQ==
X-Google-Smtp-Source: AGHT+IHBRA959tJKQ7jnBDww7hLjflOoCbxbxU4OC4L9uyovk7KidWNus9mZc9b5/3C/KVDAr0hL4Kjy/lMZJqv9EF4=
X-Received: by 2002:a2e:86d6:0:b0:2c2:9e5c:2c82 with SMTP id
 n22-20020a2e86d6000000b002c29e5c2c82mr13644840ljj.46.1696872635192; Mon, 09
 Oct 2023 10:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com> <2023100921-that-jasmine-2240@gregkh>
In-Reply-To: <2023100921-that-jasmine-2240@gregkh>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 9 Oct 2023 19:30:24 +0200
Message-ID: <CAKPOu+8Tb2CopWgBN29hmJrmU9mjG63PyVoaewuY0FYj=aGTZA@mail.gmail.com>
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 9, 2023 at 7:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> I'm all for doing this type of work, but this is going to be rough.  You
> sent patch 6/7 that hit almost all subsystems at once :(

I wasn't sure whether splitting patches was desired. In the past, I
was often asked to fold multiple patches into one. There are so many
opinions :-) but I'll gladly change to whatever is asked.

> "*const*groups"?   That's a parsing nightmare, really hard for humans to
> read and understand.  Doesn't checkpatch complain about this?

No. I'll change the coding style (and maybe take some time to fix checkpatc=
h?)
