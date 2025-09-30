Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDFC1C01;
	Tue, 30 Sep 2025 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759190746; cv=pass; b=GHBTVHcglSadThYO9ZSBIhujxawwom00UseBnorKo+hCrZkNeubqwES6Br4Uqe0Jd7DLzZdbpNSV4iKSoFhRsBBuZ034zyMwPYAKbfUq9YmYBuYDMiWSqRg23TYzM/FXG6+rd7gs/inYGs6Pg3zYEhJmTtVNxFkOeGWkKTffD5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759190746; c=relaxed/simple;
	bh=XGFVqGyz9X5OVm2kXmZ85c4YOsRXKyQlFL7nb3VNk4c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IKLfwuIBVYdLF8w/ZZaJr9QOlQiG8MMkn83Z8Q6B+vsUvGSO2FiozrQBjFSxAvxA2YmcKX2QPbjOsLeoHW2TrW8zNXCvE3Ydi+CX0JJ6/JT3Q04GI25JVduKs1r0kyPdoxpI8C3rpaEoAllEi6jk12bhx0nKEKSoGVC5pWYB0bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=YcMEmr7Z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="YcMEmr7Z"
ARC-Seal: i=1; a=rsa-sha256; t=1759190724; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kd2Zqd1/SDnVfLINyXfQK9f0jBNpQuNU+vbTOseKt/jadwjeHyErHzfSd5DgdhuldLRSwrMYiN78ZdvQspxbprcjVWuhq9qyIzesW6wCoSE1llYIN9NLqFLXo+4uzA5o8EHxq8NkHdo7GVK+WyTtVZXB0Gmv9+DYeLROLBui9QM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759190724; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C5DRleCdQ5tUtCjl2Aict7jDwzn5CPZumXDtwTbTA3s=; 
	b=FppAQbvRrH29KDaA+5FsQCYfFLzG38oAySrQ9erUpy0M2dOPvk7LdE8UZ8tUDiHfDJv6wHNAbtYuJJYmc5zk4/pa8SpR8+pE3SIidzHS86A9Wj9n77ZDQ3HPEcNULOqk0DOup60/kA4fIxT5VH8t4U7i1ax+gKEQ3WZEtZcUut0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759190724;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=C5DRleCdQ5tUtCjl2Aict7jDwzn5CPZumXDtwTbTA3s=;
	b=YcMEmr7ZQ7DWc2t17JJcipR9nTQS4G6XATjgVmUtAx2FZvR7z5EpTVPqCTMC6SrS
	Q6MYRhVV4oRzfVofRt3UKiqsmKh2vtEibbuwl88Kx8hnnl8lzeXGm6era+ZAcFw4ol9
	mwe9WjjVfd+R7ot3TL/PXP/JMk0+/tV3SlFrop4o=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1759190721130614.1293756204246; Mon, 29 Sep 2025 17:05:21 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:05:21 +0800
From: Li Chen <me@linux.beauty>
To: "Ming Lei" <ming.lei@redhat.com>
Cc: "Markus Elfring" <Markus.Elfring@web.de>,
	"Li Chen" <chenl311@chinatelecom.cn>,
	"linux-block" <linux-block@vger.kernel.org>,
	"Jens Axboe" <axboe@kernel.dk>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"Yang Erkun" <yangerkun@huawei.com>
Message-ID: <19997f021ec.1a9fd75f968161.8895471846650325801@linux.beauty>
In-Reply-To: <CAFj5m9+FGzRV+fsWtsVSHV4JFh9Pit-KFHiKRWtMKBpM9LWBhQ@mail.gmail.com>
References: <20250926121231.32549-1-me@linux.beauty> <9f6acb84-02cb-4f76-bf37-e79b87157f1e@web.de>
 <1999588f143.5af31c76548207.2814872385181806897@linux.beauty> <CAFj5m9+FGzRV+fsWtsVSHV4JFh9Pit-KFHiKRWtMKBpM9LWBhQ@mail.gmail.com>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation
 error
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Ming,

 ---- On Mon, 29 Sep 2025 23:01:50 +0800  Ming Lei <ming.lei@redhat.com> wr=
ote ---=20
 > On Mon, Sep 29, 2025 at 8:54=E2=80=AFPM Li Chen <me@linux.beauty> wrote:
 > >
 > > Hi Markus,
 > >
 > >  ---- On Sun, 28 Sep 2025 21:48:23 +0800  Markus Elfring <Markus.Elfri=
ng@web.de> wrote ---
 > >  > =E2=80=A6
 > >  > > Fix this by calling fput(file) before returning the error.
 > >  > =E2=80=A6
 > >  > > +++ b/drivers/block/loop.c
 > >  > =E2=80=A6
 > >  >
 > >  > How do you think about to increase the application of scope-based r=
esource management?
 > >  > https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/fil=
e.h#L97
 > >
 > > Looks good; I will add a commit to switch to scope-based resource mana=
gement in v2.
 > > Thanks for your suggestion!
 >=20
 > Please don't do it as one bug fix, the whole fix chain needs to
 > backport, and scope-based
 > fput is just added in v6.15.
 >=20
 > However, you can do it as one cleanup after the fix is merged.

Noted, thanks for your tip.

Regards,
Li
