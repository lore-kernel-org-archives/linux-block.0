Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5FC282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B78206DB
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AoSoWPhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgAHNGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:06:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37817 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAHNGj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 08:06:39 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so3115004ioc.4
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2020 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLxLERPumeN8sJpIDdpa4Drgsn9GaWWrGbgvRcWSe2M=;
        b=AoSoWPhEGrh+TRuofKiCzp+l09IO4FiB98EE2yXg+ejc27NTJJA8bvyvXeDaBOVBMo
         E/AIvsl7qbTplYuzjuIG4nQW8zHudVkX5UVgIvXzc8S2nlzTT5sJgsFh0naJ4l15kPlL
         yfPn30xfs4KAzs56QMBRPkjcsypCytvrc0Wrm2w5jtT4nClsYM+Q5uM9cqmmkIyxVBYn
         7LrxzCfHX+69d0crOg/LOLbpt2yagkZ+8H9HLimtcsn702huUDM9df8awvvkpsuOpUCz
         j5KgcN2Qn64/wzCy/RejeTICIPUdRRMQsh+XfqpGEwiBvCLV+9GcpVbpXBlRwRiltsOA
         eiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLxLERPumeN8sJpIDdpa4Drgsn9GaWWrGbgvRcWSe2M=;
        b=tSV2uVtl6RHD+qHP0YL9xKbBNjrbtnjOowCcOad31JjhEYrF41kdvRHFwnx9+oYQiq
         +7IIkGD9y2lUZ3mzlt5HWdDXkr9TLRJpWrtCxzu/fW+8oK2l2XxV1avA1bw69r9EZ+p0
         LDZ27z0Bhw5UcBTNaC5GTKy6y+9KJhvwt/J73Recfn9pkK0N+8IXIJx0PAIxVMiQrvxI
         g+PQ4zZsE/387gkKTL+yuwqI+jQbd0kwEstalo1mBvJmLOLr3xlDLjTn8qHbulYHWiAK
         VQqhjzcrrsm8/x9RosQy+zkG8Ky0XUp04ola85F+2uWDmzyRr6Oy5jIKmoR1sEtDcyOn
         r7gQ==
X-Gm-Message-State: APjAAAW9m+AbcTtR/fqXjDgqPHtqQXIhhX6sd+Gg5u5+NliLqRgrNwFy
        glvwTJncZlu1KBN3DkFtOqDJLUO+mYYFpQHYaNf48g==
X-Google-Smtp-Source: APXvYqwRtCSmNpIp17l1ZaItYRqohple3ymzlbMbTRvunpbxvAJjVh/A16oxOX/Io0WHbefu7bLHsIlOEaGh0+jG6zk=
X-Received: by 2002:a02:6957:: with SMTP id e84mr3915562jac.11.1578488798382;
 Wed, 08 Jan 2020 05:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-19-jinpuwang@gmail.com>
 <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org>
In-Reply-To: <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 14:06:27 +0100
Message-ID: <CAMGffEmRF+2SZ5Nf3at9SohZXTT3siakBYoZpErN=Tr_PCA9uw@mail.gmail.com>
Subject: Re: [PATCH v6 18/25] rnbd: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 3, 2020 at 1:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +static const match_table_t rnbd_opt_tokens = {
> > +     {       RNBD_OPT_PATH,          "path=%s"               },
> > +     {       RNBD_OPT_DEV_PATH,      "device_path=%s"        },
> > +     {       RNBD_OPT_ACCESS_MODE,   "access_mode=%s"        },
> > +     {       RNBD_OPT_SESSNAME,      "sessname=%s"           },
> > +     {       RNBD_OPT_ERR,           NULL                    },
> > +};
>
>
> Please follow the example of other kernel code and change
> "{<tab>...<tab>}" into "{ ... }".
ok.
>
> > +/* remove new line from string */
> > +static void strip(char *s)
> > +{
> > +     char *p = s;
> > +
> > +     while (*s != '\0') {
> > +             if (*s != '\n')
> > +                     *p++ = *s++;
> > +             else
> > +                     ++s;
> > +     }
> > +     *p = '\0';
> > +}
>
> Does this function change a multiline string into a single line? I'm not
> sure that is how sysfs input should be processed ... Is this perhaps
> what you want?
>
> static inline void kill_final_newline(char *str)
> {
>         char *newline = strrchr(str, '\n');
>
>         if (newline && !newline[1])
>                 *newline = 0;
probably you meant "*newline = '\0'"

Your version only removes the last newline, our version removes all
the newlines in the string.

> }
>
> > +static struct kobj_attribute rnbd_clt_map_device_attr =
> > +     __ATTR(map_device, 0644,
> > +            rnbd_clt_map_device_show, rnbd_clt_map_device_store);
>
> Could __ATTR_RW() have been used here?
As replied in other emails, it can be used, but we prefer to keep the
prefix part.
>
> Thanks,
>
> Bart.
Thanks Bart
