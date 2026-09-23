Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F9492196
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182964; cv=none; b=ChLs+qFQf+z7ExZMgvUTQnu4+rSEtuJlMO75FMXP69xNrk5bnPR4YzW2afk7CiqhgjCXyjdFpGRtesMDAsf52v6ZIEEdHMoFzBUs3kedn+lnIGdf+tTsJ1qSPNingtKEHxpa+3EHt6GTXm1DZVWdIPggqe+Oqxv5De8f/INqszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182964; c=relaxed/simple;
	bh=/NH2DeZ06qhNDMcOPbnvm9Cxk9uzFAwfdq+WiswZzqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOtUq0YWX/3ldGyleBZGqe2p5ut4Z1kCnyaTASI/Y46w29GyfEe9BdC9pzkO7anq1XQBdb+bnwhbN0k0TgTAxMdM886krqCNmajczhG39DpAuwmv506phMvPK3zT7HfLoF6MAcSO34vEsuGqEI1pNXdgTvy0ciudMTpEWItcnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GZidThcv; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GZidThcv"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd046b87so912795c88.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790182961; x=1790787761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pgSkp5FiMU2Sr/765lAVfBZAl/tzgXLFgid/WnLAAO0=;
        b=GZidThcv/egS57EqKUpvRzxLWSl4TbteAUcm0eyyvl6HM/IGuc1C6WjOxujI2xGavC
         ejtD55xT3zYFIUPj6mxAu/cG3YIw1jTFKshbltrH3b9qCCOcwGEEXYO6Q10hurMZdLYo
         sl6DFVUFIfois3QVM0tYRut92RKl0v0gf+7gytWBZRkCfq01jKWRHVLMAmAaBQA52Gmg
         rh446P91I0RYGUPJVDqStWKlzjEm3QpkQJS3C7fNCp5EqwP+nOCMCrIyQP3EJaIC4r0Q
         hZtdtM+K8SYUHVXV7bhFuVyvF1HTxZvyUV8w472tSV/SpKAEu+odC8fnOMBdjwiNoB55
         yXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182961; x=1790787761;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgSkp5FiMU2Sr/765lAVfBZAl/tzgXLFgid/WnLAAO0=;
        b=eOk3QKND3pIt4D3NhYMq0KRrMIgvl8adIqJbbxWjHjZI93uR1xqJiMlnY8SmjiseZV
         VpE65zb6Ca9oButVxDkf/FZ8cjjioteC51O4tPTGQf3EIR99FcDr5+gbuyStAS2tsM0w
         QW4qxXqW+R7A2HwIRvHoBDq1XqexZZo9QAzIyXQtUFX52JJ2gaMqejlkyYHgNw54M8rT
         D4L9Y8E/SCPHLE3JKm/jC5PKBRZ9GakcYJe1YnyuDP6mZmcupqQQgrE1wf5r0Vjqhy66
         q8vyyRKWrgVWjexQ2sk/8rV3bQANDi456LO76PEzg7Dmvb9i1E60xy7zoR5AAO+7ah1C
         xrpg==
X-Gm-Message-State: AFuF++klPjRKm8nzNS3FISFbWC1qQHGRrSDB4+YPeOYG1087fq6oXfXj
	+jMt/2lBgXpUTT2JkhP6ObrnryjXL6ZFm4u0GEgsac+QNIEr3Al4cBhsbbctxh94fR8=
X-Gm-Gg: AYBFou3M9tiqp3H8GAeFxRmsL54rcI2xTEzQakXpIaMspRS+big9+uyjQF6BiR4d5gR
	vzDQ5EsBu3zA26wxYZ0gabdPrCZEwT8COmL1plEIUm914PEUfdOgM3uC7v00iy2VVhkJ/09fJev
	jabLtU8PGPxd5YZ+hFCQVn/tzqpzskpKYD5DCi7NHX1SDf1HT3DkgGN7ERGJWuxCA0dESjoL99p
	Qcye7CqJQW7AuG7mZb3B0PBzKO0CUMC2XD1dGUOC+qdSSZD9SVlGPIFA+XLrGNc1KV4foxiikld
	WOs/Dh1FTr5M9U+jCKcgFaH8Ev4mcXhhzYN3gp+WP7XjC1aiccHZkWXfBIjgi9V1eg8iuv8szXp
	vm1v7Y64NIj8shoh3McpH7Evpmu5re4nCMtDmtIHfW4siX1hLTZs448EEJS65BNxGCZX5yx5Are
	eEEpQtNgCUoYbP6JCUYbPGyzLeD9ldSXkqDGTCprvh6k9fXB5GaWxUz0xbPClbfGZv7XvjNfeVV
	ENC7bCHraY4QF+ZTkw=
X-Received: by 2002:a05:7022:282:20b0:144:eab0:9cbc with SMTP id a92af1059eb24-144f9170182mr3591002c88.37.1790182960149;
        Wed, 23 Sep 2026 10:02:40 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144f9877462sm6734303c88.10.2026.09.23.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:02:39 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:02:38 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests 0/5] nvme: detect ABA ghost writes on multipath
 fabrics
Message-ID: <20260923170238.GH2931-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
 <arOFG9-sM_GrrbQf@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOFG9-sM_GrrbQf@shinmob>

On Wed 2026-09-23 17:18:21 +0900, Shin'ichiro Kawasaki wrote:
> On Sep 16, 2026 / 20:06, Mohamed Khalfella wrote:
> 
> Mohamad, thanks for the series. Before I look in the details of the patches,
> I would like make a comment below.
> 
> > Reproducing the race needs an IO that can be held at the target for
> > longer than the host's io_timeout without being failed. The first three
> > patches give miniublk that ability, since there was previously no way to
> > talk to a running ublk server at all:
> > 
> >   1/5  adds a loopback UDP control channel to the daemon, served by a
> >        detached thread, one reply datagram per request
> >   2/5  adds an INJECT_DELAY command which delays a given number of reads
> >        or writes as an io_uring timeout on the queue's own ring
> >   3/5  exposes it as "miniublk inject", which returns only once the
> >        daemon has armed the delay, so a test can start IO immediately
> >        without racing it
> 
> It is interesting to implement the delay feature to miniublk, and use it as the
> testing tool. But I'm not sure if this is the best approach because of two
> points. First, scsi_debug has jdelay and ndelay options. I wonder if this
> existing feature can fulfill the requirements of the new test case. Second, when
> rublk [*] is available in the PATH of the test system, blktests detect it and
> use it instead of miniublk. I guess the added delay feature is not available in
> rublk, and the test case won't work well. What do you think of these points?
> 

The two points make sense to me. Let me look at scsi_debug delay
injection mechanism first and see if it can be used here. I will also
look at rublk. Thanks for the pointers.
