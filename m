Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26262701CB
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070910; cv=pass; b=Mu/Q+AtxhBt9T/b01iokEGJcnoZydMuJWAA0UXnZEZzrCgjmwByg2FtKOe1J0t6qnhYSiLaP+tb6gIpMlG68a+xWHrj9JEdbHAm9Cvz5iIEH6YA49/XyuMWEmUsLZ40F2l4SXkqHPE/TFsecRves9sYYVq3I+oPluEFptwEQSBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070910; c=relaxed/simple;
	bh=wXHvhfYU+VnKtpJ55uR5VGk1VpZQ5+COHvyZm1sFKik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgLT65+hN7zHzI1EjMWivuWE2Vmk6XtoOHLpW4d+K/pvZxPcQhL8rmU7v2w6gPpMpnY7HGPuzwd0G6JZrnyrzVpiCf2ppWQUfxsufrUZSRwl4LlJjANF0Y6z7eovV4lXRDZJqgdxQqUf/6q81OH5NXki9b8N0zUMaT/TK01dC30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=To02BQMR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwNagGPN; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="To02BQMR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwNagGPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769070906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdSDHOOcqvkdeyW9YjzLDFrUBirqWu6U67GWRws3+qU=;
	b=To02BQMRTIbtRiVkNHmPjJWrfHs1B8SlP7wRXQxRVmB2Yb7iP/2tUXYh7a7ylQpoP6WaJG
	Z6VFsn+FlfOmCv1JKoEFA8XH3oYv243ESjH5y3S9/CBl8AQ7WtEDqF5wB1v9saftsInVs1
	Q/wN81n24qL8vMXZvLp9P6A1itPmo5Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-ifv1OTLgNX-V_SDQwpEBLQ-1; Thu, 22 Jan 2026 03:35:05 -0500
X-MC-Unique: ifv1OTLgNX-V_SDQwpEBLQ-1
X-Mimecast-MFC-AGG-ID: ifv1OTLgNX-V_SDQwpEBLQ_1769070903
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-385d15481e2so802261fa.3
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 00:35:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769070903; cv=none;
        d=google.com; s=arc-20240605;
        b=k27o7UHyyMXUDS/ea50S+heg9GnUu2d91i367abQKsMt6jgIw4Vu9rCKQdkYRTwhNv
         ZPJEW5C9mZF+C1WEdhDsRmiLUFaRSgvq1XyuG4jgBT2E0PyqqXHfKlue4PoZs+ydfADw
         zwqAAurE8TgVTyyvPNCfQyqQrwLb5v+rZXCBv33VEqPDFaOlkWDF3xNOfXsSCGuDSuTz
         67oib/aJJkm3mpRyxKMD9tlvZVyeJ9UwEVnUSHDNjsZkF2tt5UK6sm1Vrw4Zq5klZGau
         fZjdgUCN99l0lz6ifamHSmJst3+x8bUQ1VqoMjAbnjPBrBGoIcLnqKdGjTp2GpG2RJYN
         Q24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdSDHOOcqvkdeyW9YjzLDFrUBirqWu6U67GWRws3+qU=;
        fh=0UJpspzU8vb/Et+7l0n3viXRMfV2YLIi1fdQCqFqO8E=;
        b=ODQzSk2IaNCHZtlT4Esn9mdAFsY3+y3iFT0qz4qy528bsoqzOBfXpnmQRq1QXpJKc7
         vMMmbvXccPS0Bb9s64lgky7LxsE5BrPAdean8vvPn24LTnFLbQvYefwqNjrpNSvlh7O6
         BqwxuWKDgw+RRlM5LXnsZuYp/zi1gLNLzcmvMn/WpwiKfTrFvhedFK2BO7uyoZ8UxHKP
         Zxd0RNMnpDK7S46hGItZqpCIGhYBCxeL0qd/nb5kCYVX0I9wNCT//MNOw/I9AVQLkNkU
         pt4+emRPtpRwRhZTvJUaBQRrEMHx2sEZK58SJ0jebvwG6QC+Womi1W+aMnE/BBtNXjNZ
         lxlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769070903; x=1769675703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdSDHOOcqvkdeyW9YjzLDFrUBirqWu6U67GWRws3+qU=;
        b=PwNagGPNbeRA+V3gV52F6RHrKOd1vIofYbt+Hs9GbLei1iFwkKO8OCW12d3sK4hWVV
         RN7aimbOOkYe0fVcCe9caXQqUmI+yIzybpm3PDvOUoI/3QeelUy5M3hqMSNicwNguIbD
         hZuAM/OSNccu22VACGqpgkG1nWpaH9+DmCUIGz/MdL0Ny+/K98sXWEcD7oM68nWAY7ky
         WneGLiwA77FwYB+LWAcTDy2q0d00WikcBSNv6tVUwENa9jdq4XsTx+Zb0Dc8kj8MnW6z
         25Gstlki+2fGxZgKDoCSs730VQx/d+LfLSJwzTAFq0VJo4l+fYK8xXBjYoFdYFK2exOL
         1vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769070903; x=1769675703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdSDHOOcqvkdeyW9YjzLDFrUBirqWu6U67GWRws3+qU=;
        b=JkI0XAnnAhHjDJgng0zu644pjLBUu4heZ2SsJv67U1MqQrzf8q875Uwcm5vD/FKqQJ
         QuyG0JzRYXxkORuPU0RUmlvCHPBpJwmjnNgHnS5T2uuX+7qNkt0Jk0WwfkQvno1FCO5D
         /IQrGETiIOon3J3Tk5EKyKpfYJgJ/Cg9TJJUR+9GMTpL0NQyD3WxXxl8q9l6uP4YbiFW
         V4kz2mMblEOpt5/KSN5o2oPKNEHCgtLBlKX6VWLbGWqZtXyw0kwcslbKIEVGrNRVwHFp
         mH7MlTXWjJbbhOA7dGmerQkGGXMKrawDmDUegJgXupoMWMEIpD3UARHf+8wbaK14z3J9
         5B3A==
X-Forwarded-Encrypted: i=1; AJvYcCV3CBJtqQ8oZ4Dl/HJCDxRM/08pbLKfMH/dyH3Qxtm1ZHMVUbZ+Z7vjN7hREFbdKXCMOalnc8TZS+jj6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4dadzjlcE3uu+IafluMaSjWiUH0iPZB5K880J+R0DYg7yNbl4
	OjCBQyZQc+e0eJ9RALOinCy2C76fFKGMGcLoQRLVEcIhJbjBnEU+FrQ8JkiLJOWFus9x/j7CevS
	tpCquAGFTIL0nukc2CJomFZi/5Kc3wVaIIDxjwp99VfBgZCo0oV6QqhDesGtjN5v7iUh8D/88J9
	47IrZ2kZGG1MGNRtlGLPMuQo44tha0wCHqnUXKc1o=
X-Gm-Gg: AZuq6aI3CKiB7o5TwvS9JbM7TSQ4w6Mkc+d0GFVUbBXDdJtLImAXaAkgM8cYsz7NK07
	C2wpGiZcXL23PG+/MnNvFeW+uPtLOOY2rBTk7qYmkuclv1ZPfFbVlgZdbKbN+PoX6x/0ZxuPWlH
	aH+f8GtLGpT+QkCS7c+g16tDpPNjpMx6EroRuGe9Mu5WqUbYjPQHGqrA8j/KAu6iIg7qU=
X-Received: by 2002:a05:651c:221d:b0:385:cf70:13e4 with SMTP id 38308e7fff4ca-385cf7017a0mr3413511fa.44.1769070903304;
        Thu, 22 Jan 2026 00:35:03 -0800 (PST)
X-Received: by 2002:a05:651c:221d:b0:385:cf70:13e4 with SMTP id
 38308e7fff4ca-385cf7017a0mr3413361fa.44.1769070902742; Thu, 22 Jan 2026
 00:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122042858.1877497-1-ming.lei@redhat.com>
In-Reply-To: <20260122042858.1877497-1-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 22 Jan 2026 16:34:48 +0800
X-Gm-Features: AZwV_QhZVNKxTrMUw5d2bCuNCNqDBim7asInUDlTNUjt99DRlNfQxwDRbgk6ZaQ
Message-ID: <CAHj4cs-qCNSMvooPQGufps9ap-B1XGV_-QkNtVavc_oFCq6Mtg@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: use BLK_POLL_ONESHOT for synchronous poll completion
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Diangang Li <lidiangang@bytedance.com>, Fengnan Chang <changfengnan@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:29=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> blk_execute_rq() with polling is used in kernel code paths such as
> NVMe controller connect. The aggressive spinning in blk_hctx_poll()
> can prevent the completion task from getting a chance to run, causing
> a lockup.
>
> The spinning with cpu_relax() doesn't yield CPU, so need_resched()
> only becomes true on timer tick. This causes unnecessary spinning
> while the completion task is already waiting to run.
>
> Before commit f22ecf9c14c1, the loop would exit early because
> task_is_running() was always true. After that commit removed the
> check, the loop now spins until need_resched().
>
> Fix this by using BLK_POLL_ONESHOT in blk_rq_poll_completion(). This
> causes blk_hctx_poll() to poll once and return immediately, letting
> the outer loop's cond_resched() yield CPU so the completion task can
> run.
>
> Fixes: f22ecf9c14c1 ("blk-mq: delete task running check in blk_hctx_poll(=
)")
> Cc: Diangang Li <lidiangang@bytedance.com>
> Cc: Fengnan Chang <changfengnan@bytedance.com>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Verified the issue was fixed by this patch:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a29d8ac9d3e3..968699277c3d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1480,7 +1480,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
>  static void blk_rq_poll_completion(struct request *rq, struct completion=
 *wait)
>  {
>         do {
> -               blk_hctx_poll(rq->q, rq->mq_hctx, NULL, 0);
> +               blk_hctx_poll(rq->q, rq->mq_hctx, NULL, BLK_POLL_ONESHOT)=
;
>                 cond_resched();
>         } while (!completion_done(wait));
>  }
> --
> 2.47.1
>


--=20
Best Regards,
  Yi Zhang

