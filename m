Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB316F85E
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267803; cv=none; b=QyZPXc1Xen3Nd28D77RCJl7AS1Cw+VhclI82x/tzCI4rRikt+h2hWgEAlxx8iQDoBk5/vT+f0pwDV4lskUcEPKFxR9lx8es5K4KZDmLhnCUUHT5/LLZ+UFjoHosO2toMtKcFWPvWrpbTWiNwgQ5brwkjFKQLdLgSiFsMoSzCxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267803; c=relaxed/simple;
	bh=TFrhnSzJV3Sm6EdHAfQwawCLHMxP6B4SMw7NHep4yeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuqp81xpQtM3iCh61XTkozt67MLEnGRXxHaozpq5UIo/rIKj31Y/bX5qQkYLgGVb4JRi9P57yU3D83Dl9FM0m9m/VI8Ztb6yEmpEar2AIlGjcs9SrlMGWrcE0Rtxc3hHAXhGmzqY3FnjYLcUXbFqgoqsvlM42ICtpvPvEYItByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixEYWB3Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixEYWB3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732267800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gk4s0lN4iiQNDRkQaGooAIxufC3wWStq/REi3qziCSo=;
	b=ixEYWB3QxIPP/YhBwOOH2FYHt8Xn3aXdVrp02QYIDt9nT5M003P/j5iZsBeHytr6B/07oI
	KGuCIU6LuhefomITUCrc8lVNJAbaDgkhRXX9jdueA0FTScd7lvxnFhXWubDFumEAs4RRLQ
	auLMQumOyrD1WIJS6KkFs2svoNxiJPo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-u3g12pU3N9GhoS9Yu1b9Lw-1; Fri, 22 Nov 2024 04:29:58 -0500
X-MC-Unique: u3g12pU3N9GhoS9Yu1b9Lw-1
X-Mimecast-MFC-AGG-ID: u3g12pU3N9GhoS9Yu1b9Lw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b15499a04eso359465285a.1
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 01:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267798; x=1732872598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk4s0lN4iiQNDRkQaGooAIxufC3wWStq/REi3qziCSo=;
        b=Y5P5Jp5W/37dRDZ7HGcMplCak9ERVm78Gdzn8PiW6QAdPU1FXcA1AIAbF/R0sO2/pa
         fgK944xeN5ZQ80W/PbO21mzdepbpXCJSCuU467rlYGLBaz24WQAmh8rzhV6FD0fJM4GX
         MPhhn6SMvJXxfQ4mPA23eP9v91pImeBzwmHl0+DZm6ouPsgnM74Ke2JGdlITryRjFqxz
         g3h0GBlv95lmpcZR2xQNiVmLelGBKZN20T1ugjzsWVn0VaJCHaFtx8owHMCpBGSM8VNC
         hVvSn0vutZBODUNuBXsHfoesq/wuaL0VLcjUdBrGWAce0xlQ6HamLmzbjkp8uw6Nn0Xt
         QPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQW+yYLGrd5FuGxwZCbwCwCOjE9Ca9u8nzlfz+SgzLKqggBT237whNthwmHKFl3ve2qsTW8ESIedAwsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVvCRo1hHuKW1HGeK785oPBZ2i8pkVFjx8B8fdFW9yMIFKaCg
	HZvoCDVjj3301UiOu3CKQI9TTWUpcQjNu6WVSihIV9iAW1ZHa0VYsWFi0XNKrMJsrGn9ykzOdCS
	hmjvLyiqsIO0jmCoQN6IMkCke1h543Lh5DELYBXanENl1wJxDSOMYUXVW5jxP6lgoZgy5Co/XlQ
	x+oSqtnDnT5H6NUlkmkqjqN03vSzXoNC3sFAU=
X-Gm-Gg: ASbGncvC60iw1jbd4VqH+RFzSqFF07Hh5/MwhdHH/yvmQJn7XPOdXy3kpyr0zQD6zKr
	80v4llSUqGqkjt6AVqm9wew6DpFLuPmM=
X-Received: by 2002:a05:620a:c4c:b0:7b1:36b7:3fad with SMTP id af79cd13be357-7b50c141731mr1123650485a.13.1732267798203;
        Fri, 22 Nov 2024 01:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAUCvS1XEn13XmSk3eIlZXpYYPrj59Dm1b20gNEXQHKRZiHxF4xYL+Ca6e6c5bid26ackqyn1vdGrb3BB38mc=
X-Received: by 2002:a05:620a:c4c:b0:7b1:36b7:3fad with SMTP id
 af79cd13be357-7b50c141731mr1123647785a.13.1732267797965; Fri, 22 Nov 2024
 01:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
In-Reply-To: <20241122085113.2487839-1-nilay@linux.ibm.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 22 Nov 2024 10:29:46 +0100
Message-ID: <CAFL455kVSfcx020VAZaNPmMhJOKb_VPtaqaCvXpzPG7Rfva9sw@mail.gmail.com>
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in nvme_execute_identify_ns_nvm()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, 
	chaitanyak@nvidia.com, yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 22. 11. 2024 v 9:51 odes=C3=ADlatel Nilay Shroff <nilay@linux.ibm.c=
om> napsal:
>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  {
>         u16 status;
> +       void *zero_buf;
>
>         status =3D nvmet_req_find_ns(req);
>         if (status)
>                 goto out;
>
> -       status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> +       zero_buf =3D page_to_virt(ZERO_PAGE(0));
> +       status =3D nvmet_copy_to_sgl(req, 0, zero_buf,
>                                    NVME_IDENTIFY_DATA_SIZE);
>  out:
>         nvmet_req_complete(req, status);

I will later submit a patch to ensure this function complies with the
NVMe base specification, building on your patch.

Maurizio

