Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC71C4167E
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48C061278
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbhIUCRl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbhIUB4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 21:56:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B55C0DBABE
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:36:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso1199190pjb.0
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBRyYiFkqDi2caQiqujCQacHdwzqbQqJJTWz3cL4aYc=;
        b=u+hPjgHDtGIWQ8TWndPhOSqYbZzX6zjEaCWa3k/TRAtGNz3tYxhw9vJNCz2mGZpCI6
         MZXTeit42TdmYTb65kQT6Uo4b9spmeo1nbCStCKhL95EetHFKY+SXYY3nWet4NiDae0E
         wkyiHkn4y+irZdIImkHjRpQI1UiZ66jQDuBs0IlduZDJps5kt5uui8nHeOhqAEIWXCKE
         +SrP33uMT/bYtcVOtvWMWjNwO7ulp65R0hK/0wvK397QnRVARAm3aF0pzeD4ABhmxrr2
         whj4G9nTeVhj+mN4sa+0xAZQFXUFYJvZQ9EIJ2b5rv8DKQUj5uQ2F5RPMbNKoTtl9prY
         6KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBRyYiFkqDi2caQiqujCQacHdwzqbQqJJTWz3cL4aYc=;
        b=K8qji+2bE+X2TeWPfbrAYwxtlVHrqqYhwyYxpRaB2Tt9gUOfwEla7xBIEs3gyYBFLq
         oc8AOZG5dXPrkK2820CnS8HPbao2E2NPZc2aKaS+MmXODoxFTA1m65MmjbjU+CrVN8hM
         XApAzCAFgCrYk/O9GsFl5QXFoSEeXb9TG/igokVS9vFZ73jjspIvtsd6Cv+BxdUnZ+pf
         mQzAOi/G3c3JgXyAsRT12lvjflH+twM+IL1wLlSCnkc5/e8SfxxWh4qC+sm0gncIJmH7
         i6S3AgpZ0WwDzvOv5M0OWjEsZtiJeQkCMqaY4ddi35GwS1S38yQCkH/dMN0CFk84xf8n
         feqA==
X-Gm-Message-State: AOAM533y7KRO1DbgXxQeWGYwNGHnpxLMHQTryiz1URPVOIDTLTTfRgEh
        c1qw5Zyw2ji6/qpL/FklfnYADnP+K29kLazFgio3OImoPfk=
X-Google-Smtp-Source: ABdhPJwRKj0qu9RA5olCLKgAzMQU9EQvIzxEKw48Hu/LzbfLKZ72sH6hS8OKB+ZUBqbRq1PcxhFMZNagZ2HuHUCYOds=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1793440pju.8.1632180976495;
 Mon, 20 Sep 2021 16:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210920072726.1159572-1-hch@lst.de> <20210920072726.1159572-3-hch@lst.de>
 <20210920225125.GY3169279@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210920225125.GY3169279@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Sep 2021 16:36:05 -0700
Message-ID: <CAPcyv4jn=HJRSMKPCFZzHmMoWD2x2EGjWr0O8mB63RFHj_jDvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvdimm/pmem: move dax_attribute_group from dax to pmem
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 3:51 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Sep 20, 2021 at 09:27:25AM +0200, Christoph Hellwig wrote:
>
> ...
>
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index ef4950f808326..bbeb3f46db157 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -328,6 +328,49 @@ static const struct dax_operations pmem_dax_ops = {
> >       .zero_page_range = pmem_dax_zero_page_range,
> >  };
> >
> > +static ssize_t write_cache_show(struct device *dev,
> > +             struct device_attribute *attr, char *buf)
> > +{
> > +     struct pmem_device *pmem = dev_to_disk(dev)->private_data;
>
> I want to say this should be dax_get_private()...  However, looking at the use

No, this wants to do from @dev to @dax_dev. dax_get_private() assumes
that @dax_dev is already known. Also, in this case @dev is the gendisk
device, so this is a gendisk-to-dax-device with special knowledge that
the gendisk is for a pmem device.

> of dax_get_private() not a single caller checks for NULL!  :-(

All the callers are correctly assuming that their usage is before kill_dax().

>
> So now I wonder why dax_get_private() exists...  :-/

It exists so that the definition of 'struct dax_device' can remain
private, as no one should be directly mucking with dax_device
internals outside of the provided APIs.

> A quick history search does not make anything apparent.  When the DAXDEV_ALIVE
> check was added to dax_get_private() no callers were changed to account for a
> potential NULL return.
>
> Dan?

I double checked, but this all looks ok to me.
