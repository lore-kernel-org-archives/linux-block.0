Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01721F80DD
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025480; cv=none; b=txQVEAdb4TInxHwYcG6NCdsDRcBospSdzZPehoFNRqtrlnExtpN3EYEdrIs/emIOS4En2MEAEuY4Uok/5ECQoNAaAmvqWpiIPMNQVzud0W7EVsIPAfTE1jEqLrYTgw3lYkgBCXGoavMCF79zLgay2kaPdD4JOIY6e+UVd+sJLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025480; c=relaxed/simple;
	bh=bHG14hrGQSpai5KqJFMnfSP1YbhX56ortjMFznQtdvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT4yjHoDmNGxXCqWXHeK+IKLZcdP98Cwb/m1wcN5ZH2FgcIkr9up9U1uvXUEi54iJTeI9+T5Wa8il0RczJ465xEt7Kbw6iegBCju2OUAComGODxO1Wu8rpNsOSUwI8DhH7YElbnF/MmzW56+0hpiTq74oDWiO165Fiv63g/nLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Phy1B6+l; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Phy1B6+l"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4603f64ef17so2318201cf.0
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729025476; x=1729630276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVNM786p1ZLPjq83UTTZ75/h5J/YAHeE+f5HGIGi4Z8=;
        b=Phy1B6+lFwU6SKC6qQc2q2Hdtbi/093+VtfCBAoSXt/IvCUAj2gS97iRsIUiYG7OQ2
         qM5bSAEo/rWsV+k7/on8vk0EY2c8RiU16lGMY2e3UBh18v/u5cT5OoXX+CIcZkDY+Tb9
         4QZSAhP7ftLy7p5D/sfIAovoSClq1AKa2oEg0RnJYXHOdEnHh3dBAwYMLBYX9EVC6r2W
         1Tvksi+sRsLDlfdAOo9b3lZ1vW4vScJM+P4yzrleWSzPgfWTf44Qy4+MNEjoicZP99LR
         zCy7heJnFbXL+zQJ1EB4yRlztK/pGbGWKlU237jEkK18qFOyUcVGmYBN6HHX4MrjO+uW
         q5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729025476; x=1729630276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVNM786p1ZLPjq83UTTZ75/h5J/YAHeE+f5HGIGi4Z8=;
        b=anQIu4cccMkZyYX3zyW/PzOqQ3fhAURpoesEbqs3MScSmkBP7EtTB1IfouyEdX/0zg
         36M9rQ5tqs40VvYLWZ7D262E8XxIVH1KdRFVFmWHpPZJpSZiK5xaNwzMNgVtUqynOsCB
         lGqkhsIHVXTGUweTLg/wfROZFKvbSuHcxREpSWp+/XBpLysAEWKFFDQurgbBMuEH0gtI
         iXbbJV3WNrlOuNjYknjM0P1hPlY3saXuWvdVyXOnV+dPzBo5+8uNbhQr5drGO5cMe4fb
         dP44Pdrx7J7VpQM7uDwy+CHXuZK7nEUTr+qtKd+W7WBMFfNbbn72TwryF/TFqO/KMMI9
         WgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+6g84cqFZxemVA/YlJHYrWM16NhBzNfgWQtOpRccWh5GFLeYcOinQBs0TbJSwNZsZcOyB+ofbaucVoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+L4HINW6SUYoOs818z3ZzmMGXA67pVNGXBggD0XDCdrBtMt24
	daMgBPPpqngomRB4FxfVKI0/LYLgwwotje9cLTV+pQ8RjL2P0Xum7OgUir2SHQPjlzD7e54Ny6v
	E6afM7VhGjdNTjEp+OWlV3YqG6QtOMm7s
X-Google-Smtp-Source: AGHT+IF37guVaImyqyoBZvUR1Cd0UduUKmtTgG8eF3VDtCjKmJhYju1jaLvJacMsRIzA7rrjILVaEU4UvzfO
X-Received: by 2002:ac8:5a84:0:b0:458:25ec:68cf with SMTP id d75a77b69052e-46089b2d12emr25632271cf.13.1729025476558;
        Tue, 15 Oct 2024 13:51:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6cc22971d2asm627616d6.51.2024.10.15.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:51:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C4B8134047A;
	Tue, 15 Oct 2024 14:51:14 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id AB68AE4055F; Tue, 15 Oct 2024 14:51:14 -0600 (MDT)
Date: Tue, 15 Oct 2024 14:51:14 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: eliminate unnecessary io_cmds queue
Message-ID: <Zw7Vwsh3G25bbl93@dev-ushankar.dev.purestorage.com>
References: <20241009193700.3438201-1-ushankar@purestorage.com>
 <ZwdNvyXdXbsCf9MF@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwdNvyXdXbsCf9MF@fedora>

On Thu, Oct 10, 2024 at 11:45:03AM +0800, Ming Lei wrote:
> >  static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> >  {
> > -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> > -
> > -	if (llist_add(&data->node, &ubq->io_cmds)) {
> > -		struct ublk_io *io = &ubq->ios[rq->tag];
> > +	struct ublk_io *io = &ubq->ios[rq->tag];
> >  
> > -		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> > -	}
> > +	ublk_get_uring_cmd_pdu(io->cmd)->req = rq;
> > +	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
> >  }
> 
> I'd suggest to comment that io_uring_cmd_complete_in_task() needs to
> maintain io command order.

Sorry, can you explain why this is important? Generally speaking
out-of-order completion of I/Os is considered okay, so what's the issue
if the dispatch to the ublk server here is not in order?

