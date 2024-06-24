Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5D134415
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226851; cv=none; b=Rh21dg14YeR1TMZqSaBGYyHfngwfnl/uG3IJr4QJCNF5nktc7o0rW2+J8FifM387bgO9f3aqWpwcfPeeeuVf0zYvMsnvJvGPdmXJ79DWygJURz2VmWL+BifgP/HMntUphyEBJmcMf+vSn+RKzVLrnnKquI/XgLe+djdOFm5iNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226851; c=relaxed/simple;
	bh=CGGWNzeJ9bDwbDnvor39Fmq+BRaZ5agoXe+Ub9GL1Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqkEM6oOQ4kS/G1UY1l9/CQG/o307eCm24ChU0ssHfay+aITciclwj3MfPxPokRlMYD0Ml7kJzabdlsJAUsm8FpCJm/CX8INX4j0Z+TFbJR5LLETbmBJ8wQ/wak9D8jKRYVlpssQAfFOZDSDY2leg0ei6QAygB6//49zJQ9HGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IBeoVPhi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IBeoVPhi"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso60895461fa.1
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719226847; x=1719831647; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnJUqjkeDWoCRlxkGty/zZG8G+WoguTB3yye4vS5gwY=;
        b=IBeoVPhisikzeE3OLWEpvvfEtW+18mqvg64z44ZcJZSkUznslOAn5c0yQhzWQq0OkY
         7AOHo1eOkffXA/vZ2MCt8PlP4AnKenVbSCBYjZsWpk6RrnUZc08oPmZ/ScQyJvsV+Sy0
         dxtAcpuZsiVPJfy4NRdKsbjHQvq2udh2/wLLPD9MDthbNjKSHWikp0EEzlSBWAMYiyQr
         VbSgdDKZWlXToboDoEjepRlUpAnp4ISz3IG1Toj0uQIjWBAF7OJiXiisprlzxyHwe6X4
         zDQLux8Od7/kYPYqszK0wa+80+iTb5IpWxErB0j7AR8wuypBr84CAC3BuU1dtGcasVdX
         UzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719226847; x=1719831647;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnJUqjkeDWoCRlxkGty/zZG8G+WoguTB3yye4vS5gwY=;
        b=osFmuvM2X55TOZPOhhd+dfBNAyLUNqJSwOaE452XjaWaQFN4fHPNJNzKPRXevM+1ku
         DmSEH2ZmC6DrQvl6Cez5MNidSe++ul4adkKL3ep2FZI0ITRMGixXhKio126YNSsVzaFV
         dPsey/hGtbQXQTQnqZV8rHfanJFEWDW+rJ2mtJNDuEumYp2+xMmGWGxqEIDOD0+EwwxJ
         nx1ujUMQF0rIqmBAer11Mzzhg0PLI6b+VRuvQm83M4TFo/4R2p7Q5y1aHtuNp2WK41gB
         LS9kpTk+y4yz3cNC+grADRdRsOoVra36ATje8TceBhunRe5fDmjX1UhkGmn+skLJB3JG
         WBQw==
X-Forwarded-Encrypted: i=1; AJvYcCXHkminvkJDkotPNVPBi69rppaYo1w/0v6mUCLZpFgeLG1qvQCzg2QaubwwIjctOn0yhv7i3i5qz203zZXgeY/8rEZVxYu5hPKLvMk=
X-Gm-Message-State: AOJu0YyoFprVZhC6rVyp9Lgy19ai0VYEHR05pki6ZLixZgNmIJ0eoeyE
	YlPom0pUL+THgRCmK81vxjpehQc+6I19YEf3PLAD2m2j8VLA1Qv1TtwnUs5o6HQ=
X-Google-Smtp-Source: AGHT+IEH/rqTkvr1EKOQNPG7uzHIakHpNGp1YpDRaLAqtZ+FQJhnS5WXlhbms5LsypyfS2BSIY63uA==
X-Received: by 2002:a2e:321a:0:b0:2ec:4d8a:785a with SMTP id 38308e7fff4ca-2ec5b2c4e90mr35256211fa.4.1719226846954;
        Mon, 24 Jun 2024 04:00:46 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb329a33sm59962295ad.116.2024.06.24.04.00.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:00:46 -0700 (PDT)
Date: Mon, 24 Jun 2024 19:00:41 +0800
From: joeyli <jlee@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240624110041.GH7611@linux-l9pv.suse>
References: <20240624064418.27043-1-jlee@suse.com>
 <2024062448-crushable-custody-dc7e@gregkh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062448-crushable-custody-dc7e@gregkh>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Greg, 

On Mon, Jun 24, 2024 at 09:05:59AM +0200, Greg KH wrote:
> On Mon, Jun 24, 2024 at 02:44:18PM +0800, Chun-Yi Lee wrote:
> > For fixing CVE-2023-6270, f98364e92662 ("aoe: fix the potential
> > use-after-free problem in aoecmd_cfg_pkts") makes tx() calling dev_put()
> > instead of doing in aoecmd_cfg_pkts(). It avoids that the tx() runs
> > into use-after-free.
> > 
> > Then Nicolai Stange found more places in aoe have potential use-after-free
> > problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> > and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> > packet to tx queue. So they should also use dev_hold() to increase the
> > refcnt of skb->dev.
> > 
> > Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
> > Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts")
> > Reported-by: Nicolai Stange <nstange@suse.com>
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > ---
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Thanks for your reminder. I will remove stable@vger.kernel.org in next version.

Joey Lee 
