Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA7BC433E6
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 13:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA1464E9B
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 13:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBAN4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 08:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhBAN4S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 08:56:18 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087E8C061756
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 05:55:38 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t14so12198571qto.8
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 05:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=COduLqDzEnucCo1GUL5zrrNpSeN58CB74Mgz/6CnMhA=;
        b=GdZEFO8ZrdDaBqtgvFDLihyULp7aqWzseqf5jsxaAOG9bJLsm6pYUSu0IsiRiHX/nf
         B5x22PFAC60ogxIw8ze4F7MxgjjTrV4R3e6H+4feIV2dCAcawigAl1d0eZsQQHahbo/+
         TcXULzDKqLA4saxB8jjvxzWY79+z198iVULzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=COduLqDzEnucCo1GUL5zrrNpSeN58CB74Mgz/6CnMhA=;
        b=Rn05fKl2CIPcqcw5THu5yAo40lkZO985xYD6MNxPIcTLgX+pmn6yPHZwqGG1ENISq4
         NptMVnpnbKaGyM/1AYca0kzVGIGUHbibWwnUcfJ9QVFDCC9uiaeMA+XJUt26hrm14bCZ
         SSj3G3L6rEhTegjK/65OZhzs9N/yYj8ZWHSx/lKesFy+Dsze6tjnth8zeC5vFl1+zpu2
         HM4aZCKiXC3jrqe8lqWSKbpudG3xroc662fX6P7uzlkPE5F4onNz36sawTi2ar3w6/P2
         au2f3CPPMkW7stH0bZTE9P9DjaMKJOh1R2JaaJSOSNAlzffBj+quJ+HZuAY2F9YgAQXU
         Dckw==
X-Gm-Message-State: AOAM532Uq6LnHncQNGPFF6IrQeA0gVGlEKWqBzqD0PDvXYisU9kTAu/M
        qzCZjvlouhaEadGIkPEUbRPhReauX9dpKexiitSVEw==
X-Google-Smtp-Source: ABdhPJyOBfiztPB+NcXuBiXaMD65uEeT43XGTPbgbkfliqA7LAr9qjH/0WcjwTg45Z2gEepzH4UlIk7F+e9CTylRLRE=
X-Received: by 2002:ac8:130d:: with SMTP id e13mr14984705qtj.216.1612187736923;
 Mon, 01 Feb 2021 05:55:36 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20201203034100.29716-1-kashyap.desai@broadcom.com>
 <20201203034100.29716-3-kashyap.desai@broadcom.com> <379caf31-6158-cb4b-325e-0be3b79b97b9@suse.de>
In-Reply-To: <379caf31-6158-cb4b-325e-0be3b79b97b9@suse.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHOEf3M/0CyAu39AtgNSQNXwBT1dAIUsluLAeMqdfCqNWBW0A==
Date:   Mon, 1 Feb 2021 19:25:34 +0530
Message-ID: <534865e428d0452f3355e05fd55b4138@mail.gmail.com>
Subject: RE: [PATCH v2 2/4] megaraid_sas: iouring iopoll support
To:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        linux-block@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006642d105ba46b5e3"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000006642d105ba46b5e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >   static int megasas_map_queues(struct Scsi_Host *shost)
> >   {
> >   	struct megasas_instance *instance;
> > +	int i, qoff, offset;
> >
> >   	instance =3D (struct megasas_instance *)shost->hostdata;
> >
> >   	if (shost->nr_hw_queues =3D=3D 1)
> >   		return 0;
> >
> > -	return blk_mq_pci_map_queues(&shost-
> >tag_set.map[HCTX_TYPE_DEFAULT],
> > -			instance->pdev, instance->low_latency_index_start);
> > +	offset =3D instance->low_latency_index_start;
> > +
> > +	for (i =3D 0, qoff =3D 0; i < HCTX_MAX_TYPES; i++) {
> > +		struct blk_mq_queue_map *map =3D &shost->tag_set.map[i];
> > +
> > +		map->nr_queues  =3D 0;
> > +
> > +		if (i =3D=3D HCTX_TYPE_DEFAULT)
> > +			map->nr_queues =3D instance->msix_vectors - offset;
> > +		else if (i =3D=3D HCTX_TYPE_POLL)
> > +			map->nr_queues =3D instance->iopoll_q_count;
> > +
> > +		if (!map->nr_queues) {
> > +			BUG_ON(i =3D=3D HCTX_TYPE_DEFAULT);
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * The poll queue(s) doesn't have an IRQ (and hence IRQ
> > +		 * affinity), so use the regular blk-mq cpu mapping
> > +		 */
> > +		map->queue_offset =3D qoff;
> > +		if (i !=3D HCTX_TYPE_POLL)
> > +			blk_mq_pci_map_queues(map, instance->pdev,
> offset);
> > +		else
> > +			blk_mq_map_queues(map);
> > +
> > +		qoff +=3D map->nr_queues;
> > +		offset +=3D map->nr_queues;
> > +	}
> > +
> Seeing that you only ever use HCTX_TYPE_DEFAULT and HCTX_TYPE_POLL
> that loop is a bit non-obvious; maybe it's better to unroll it and assign=
e
> the
> values manually.

Hannes- I have taken care this in V3 series. Please review.

> >   /**
> >    * megasas_enable_irq_poll() - enable irqpoll
> >    * @instance:			Adapter soft state
>
> Double newline

Taken care in V3.

>
> > @@ -4164,6 +4203,8 @@ void  megasas_reset_reply_desc(struct
> > megasas_instance *instance)
> >
> >   	fusion =3D instance->ctrl_context;
> >   	count =3D instance->msix_vectors > 0 ? instance->msix_vectors : 1;
> > +	count +=3D instance->iopoll_q_count;
> > +
> >   	for (i =3D 0 ; i < count ; i++) {
> >   		fusion->last_reply_idx[i] =3D 0;
> >   		reply_desc =3D fusion->reply_frames_desc[i]; diff --git
> > a/drivers/scsi/megaraid/megaraid_sas_fusion.h
> > b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> > index 30de4b01f703..242ff58a3404 100644
> > --- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
> > +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> > @@ -1303,6 +1303,9 @@ struct fusion_context {
> >   	u8 *sense;
> >   	dma_addr_t sense_phys_addr;
> >
> > +	atomic_t   busy_mq_poll[MAX_MSIX_QUEUES_FUSION];
> > +
> > +
> >   	dma_addr_t reply_frames_desc_phys[MAX_MSIX_QUEUES_FUSION];
> >   	union MPI2_REPLY_DESCRIPTORS_UNION
> *reply_frames_desc[MAX_MSIX_QUEUES_FUSION];
> >   	struct rdpq_alloc_detail rdpq_tracker[RDPQ_MAX_CHUNK_COUNT];
> >
> Same here.

Taken care in V3.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg HRB 3680=
9
> (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

--0000000000006642d105ba46b5e3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
yfWKfxJx8FcWmsjkSlrwDu+oVuDUa2wqeKBU12HQ4JAVd+LOb5edsbbFQxgGHu+MPuc/1hl9kTkC
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQU4dX1
Yg4eoWXbqyPW/N1ZD/LPIWcwDQYJKoZIhvcNAQELBQADggEBABBuHYKGUwHIhCjd3LieJwKVuJNr
YohEnZzCoNaOj33/j5thiA4cZehCh6SgrIlFBIktLD7jW9Dwl88Gfcy+RrVa7XK5Hyqwr1JlCVsW
pNj4hlSJMNNqxNSqrKaD1cR4/oZVPFVnJJYlB01cLVjGMzta9x27e6XEtseo2s7aoPS2l82koMr7
8S/v9LyyP4X2aRTWOg9RG8D/13rLxFAApfYvCrf0quIUBWw2BXlq3+e3r7pU7j40d6P04VV3Zxws
M+LbYxcXFT2gXvoYd2Ms8zsLrhO2M6pMzeNGWk2HWTof9s7EEHDjis/MRlbYSNaohV23IUzNlBw7
1FmvvW5GKK0xggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDDSdoX7GqonhoE7TszANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgQwN26nWb
IYtIOzqTFvA9E9CJKQdwOMcltduzb4HWV2AwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjEwMjAxMTM1NTM3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADC0rgkf4v52AN6qoLvrEqAAYcCM
XXyzMI7Y2CwXUdiCLUlnJoYFRKMgHMZPICFbJz0o1SvYWFbEuab6rJSs4uf6XputfolqfpnZ4a3w
0DdCM7hNOJknSTEdL+eCO4SDAJGBxguCtfm/vrCnFCejvz9hPj8wZrkPte9EuCch3llJi4FT0tgH
61o76+QNCJghjeCl5ZA2kKj83rM8fGGisAeoQNNN+Q5jWnB/1jea/9xkLlS/ZAbxRyv8gqoLZblx
zOvQgn1KXSEQeLk3/nz1VwhoLtzhUy4gikgI1yD4NV9HgCcJB+DlGrt3/n+L9VscM9150aWkGNto
qdDNIFXnK1w=
--0000000000006642d105ba46b5e3--
