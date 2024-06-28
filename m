Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E36F2F3;
	Fri, 28 Jun 2024 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556724; cv=none; b=jj29O6MiB0kEvce+RHsPVd+9MnO//UvnTQoCcs1UMIDz3oUEyiomYUJbt3weasWaClkqvdynxj/AngGjT3YOZBWhs8HA35ckvVrFp7EXQWHiX/DYztZ6tirddPXJFk2YJHZghgbQtEvAsInx4QGt2npG2BqlysEUgR3WdZcCpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556724; c=relaxed/simple;
	bh=WecJ8hdHuSsABDP03odUtRdvZnF2aL6vFJcW17O/iVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOTIj8o2yTfs6A/YDlBx0ZIt++N72s5wcO5wFHFwH5adcL6XQ6XWS431SyYJZv0WW+AfJ9iD/6SIlWgQiNv8tP4tH9iCdHL2YURc6uQu/nZZhxwms1BIXUQR9vJ8AwtnY85NzbfKeRj5S/YOg9WvXTohDMvdeIV0HxCqT8py1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9J+SZvr; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9J+SZvr"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44636bd6e22so1958411cf.2;
        Thu, 27 Jun 2024 23:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556722; x=1720161522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WecJ8hdHuSsABDP03odUtRdvZnF2aL6vFJcW17O/iVw=;
        b=h9J+SZvrdfwhKKqRfu8coCO+WeYVRJMONMn5b2vCVOsBIg4NQuJBt9YOrhCi7nGGW6
         YKtIGaCBGQOCm/RxzzsvzOj2VtZ+eNW/aFP4cAe1O1NxYfnyHUlQg0u7i0eD4UWTIW+r
         v6NyR3vNpAA3K6rJDFBJUHksljMMTq9MSTzhUUMCCr3MHT9/yF20/PmpY4mDgdO0WdFz
         AR93C4ix15gacec135iPwPqpi13EMPzsBdH9KGcpKfpwFUIIAPbN74p98Ycn6if9ojEP
         lHM/6x8Kgqa3LBCNCXCU436czCA2b0XHcvh3U8nis2ySM2P1LaHS0XVmWVw5awhHN2Gg
         57jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556722; x=1720161522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WecJ8hdHuSsABDP03odUtRdvZnF2aL6vFJcW17O/iVw=;
        b=jMho8NmbPnmL4cKuE6dmCPUrqs54D8S28ZYACVO9o88wQD3LggmXxQs8dgRIsau4X0
         fBxLbVgHf9McIIb8QFdl8NAqHJtoNrX4Y9kA1BDJJ2lSkxAAbO6KSbR/47EUUzMgApo1
         CmNzr75nAKPk3/L10UQvKYBu/zP/o60ri6FXX4EAvUq/m0OPYnC0LiAJ4jD4OD31Tu4R
         MNB0Uq1ToaG1EUFjAcdc4J34wMnziXeGHrmEoyhFhDrxqe1EWyemCBJfmqnxTBkqHMfD
         tDJVqybTHvprV1UCDciN7u/SupQEXWtEG9unKuSMqRScIz87iBuHNFzhrH+q78a1ERLX
         I7rw==
X-Forwarded-Encrypted: i=1; AJvYcCXu6nQP8IHHRCr+k0VPTBuT4Ye14p1IQFGWm7ms+B5ruVun0FUrapQTgPpHI8ZxCuE+wzqWIwZpKvDpdI0hxacCVd6Qs86cQrYDXDF/HlVfPlkkKAlsN71xscvEjJ4/fgqi+maONkcDJh0=
X-Gm-Message-State: AOJu0YyWQnlHKKct+YFn2ViE3bwG61YaGRq+D4kD04vRWw7p22nOn+vo
	evpZQb8cEVdsm5DQIt2MgIN33xIgJe6Eha9hk9AvUANSGHNzan7ql/aPiu0zbootKedhpdW/vlW
	nDX3cirg35mqlHdvFqcIC9y7h+Q4=
X-Google-Smtp-Source: AGHT+IHqxKGC54vGuCvp6vdmN93tIm+gLw5Kg2OmzgRXkeD23c4M0oLT4FNPRtEH+Mx1JzEdGSCw53lFlnAoCmXse8M=
X-Received: by 2002:a05:622a:1788:b0:440:9078:f438 with SMTP id
 d75a77b69052e-444d3c0e2aemr192035141cf.49.1719556721655; Thu, 27 Jun 2024
 23:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614074936.113659-1-dongliang.cui@unisoc.com> <43b022e5-18ba-4f03-907b-4bf148fa102c@nvidia.com>
In-Reply-To: <43b022e5-18ba-4f03-907b-4bf148fa102c@nvidia.com>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Fri, 28 Jun 2024 14:38:30 +0800
Message-ID: <CAPqOJe1iDAHyag6YF7oao5vjik3R8YxaoRtjiBy3aOGhc6W4wQ@mail.gmail.com>
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>, 
	"ke.wang@unisoc.com" <ke.wang@unisoc.com>, "hongyu.jin.cn@gmail.com" <hongyu.jin.cn@gmail.com>, 
	"niuzhiguo84@gmail.com" <niuzhiguo84@gmail.com>, "hao_hao.wang@unisoc.com" <hao_hao.wang@unisoc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akailash@google.com" <akailash@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:29=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/14/24 00:49, Dongliang Cui wrote:
> > Sometimes we need to track the processing order of requests with
> > ioprio set. So the ioprio of request can be useful information.
> >
> > Example=EF=BC=9A
> >
> > block_rq_insert: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
> > block_rq_issue: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
> > block_rq_complete: 8,0 RA () 6500840 + 32 be,0,6 [0]
> >
> > Signed-off-by: Dongliang Cui<dongliang.cui@unisoc.com>
>
> Looks useful to me.
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck
>
>
kindly ping...
