Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E636F428
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787867072; cv=pass; b=PLrfAnUJnqmk2NIbhrIu7aVKcfjovGZBu7swJOdTSL3WrvjU5ENcAupE9Zz4yNi+97byudWEVuDGwMfZfhCS19hzoDlRdUyyS485iPc2U2S/Ez0H8wYDV9qNY6RV16obWGo995LPprbQU/3fSD4ccrm+3lKQckrDdO1dp0N5dY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787867072; c=relaxed/simple;
	bh=0sBuqucNWMJ3PQ7mkm0GStLfwt7hAbIgMaO5tBFyaUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E23NQOYbajELZfTsc0EzNWutOHGqDiRfOPoO8W/6XuJw0lRL8/Jm/k1ID2eQA+ksKgixrWCYBj8TSlO72yN9wvhgBKGlWLfaKddtaxS5M1+v5dLEKdI+giIsv+klgGaHkqS1eKu25/NUH/wLo6n5yGCLxBc8LzMcp6HG9WsGcT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZTrSBDI+; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZTrSBDI+"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43ce24c4978so45767fac.1
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 14:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787867069; cv=none;
        d=google.com; s=arc-20260327;
        b=f38bSTLGrwQbCDZJyoiTPF6WybH6cOF4wJrWwenXb6eEQSm3d/OUnZoIyZu/b2k2hV
         vxxagqxfX3pCKcL7nKjyxYk7h9jP3s5bMp4o3wCpcGn2AnL3bnI9WA/sYLOkxzi2n5ib
         ZIugDw/40+Mg1QzdJsQpXfvV4rgtV71b1/WG48Ww5U7DL+TcOGU7ji2ZQPXAheEpNsb+
         Ru6WdAicO7VF9qudcyLFvoZji5pmP0lVQFXjsbXAaqD7/E9sl10dP0l4FRW1PbJZ4P08
         JbF9CE+SJxMFNNz0d8z1FYgrROf/KVutK9Z8LK6ujXtqEMDAVAu3UfM5wKleF32VUjNq
         sFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kqBamkmhnxpQu01OYVCgjjVqjgGXsL5/W693jooZv34=;
        fh=43q+rts2BZYojnVguhFNPXZY2eePoxNXyJUZZOCzUgI=;
        b=Txc93/JJgjYreCx2tCR0AfH5M8GvSRmNRAqfazXO2uw5oJxQlsYD+bZZvdeFiSSc7X
         gFTFxR6gVDf4BQUfZDQYU+nMi+E9yc7G6h50S4R4H8m93ncjjhOf3SnAO7T3XfRA+cRS
         ymOq9nrPgDf06tBEVT9JimISrvwwCkYsxN3hi2PxSpdPSpQovbgr93CozVf5t7WcfqxE
         RCfZf6xIdHRRENDnjfciaX3hJtBCdPezARKEA38gWRz3CHjR6e86M9H7ZhhghT4+vxn0
         F232uMvqPxrW9yICLKT+VvsMhabVYcMtXjU24ChTSUtToZ3fMFF057TZGVEjokGO/rUf
         bgfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787867069; x=1788471869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kqBamkmhnxpQu01OYVCgjjVqjgGXsL5/W693jooZv34=;
        b=ZTrSBDI+mPv6N+9HPOoOcSbhmUkUBhPzXdGsbf4IcAnGI0Glqh1gi6UK5sJn1/UOuI
         5WmYrDNdNGftOFB6sL0MsoG/GkrMAQOqk/tokMVid4ixJn1zODd/o8mkwRCF+4s5Mx7n
         hzC5Rcnw9GFjAl5mx4JAznYgPZlfoPtUtQefmpUgYVySl+64X0J9WDaZpDg1K40kLxFw
         dRzkW1d/qKFjpgUkbllKjyQtj5tGs943l6r+mg6H+DoHnElbM1F3AcDi9+ZLC8pX+3hg
         PbdqhPbq9qlvZ9qS4MO7t8+5PpUTFYv7xwC7k48XRi0qLhUD2tMajDDlzIUqlsjJ9Bdx
         NVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787867069; x=1788471869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqBamkmhnxpQu01OYVCgjjVqjgGXsL5/W693jooZv34=;
        b=Vtx8lWoxDpk1kLEUQAgZrB1fJUPlCxzfMSK0JbzRfllXGExpqky/yAXCJCPUoYokOS
         W5QOjL0B6t3XsPd4Bim10H7lxnlrUhONL7w+VgK+AaXcxstwZmf6TW7gLFn7c1wHtlVA
         iEIg7zj3JllCLJAQ6Gzp6PBM/I4/XGpvfvHzIhxpU8iECZSCoBlL+Ku5HvFNnBQW6Kl+
         LryHBSnKOw6/orKCRzJBPh8a/j2OwMsEobIQtSj7HIEJieF7px7dGB6N9URZA5FcdMcT
         fUYtzO70d/Un5yoTkgV8YM02S2lEAsxQtYradbbn5tF0npXFu/lL/dsFa3WtPVANIxSD
         ELAw==
X-Forwarded-Encrypted: i=1; AHgh+RqPR2zgMpRrvzmB8MQBXHGnbeLhHtS2xTn1vboJ5/V9jddj1dyQTxZTRZw5hmTE+YAHYrMS4tGGxBpSmA==@vger.kernel.org
X-Gm-Message-State: AFuF++nqJwTM2GY56LVWey6n/EgkhKZh8UbfTCa+G/VqD9F34tz3yijw
	clfEJfkK0bP/pViclHqEfJB5cSQk30HhzDOELcWlTHQl0KXKpEmLMUgR6knBa/pASA0IISCH1yb
	FvBioFPCQzl47nL3UN+qafEbbN9HgPvAODgO3aA41oA==
X-Gm-Gg: AR+sD131p8rZCSe8L7/9hOSvH0Yxw0rRuhP1gYaCckOVLx6OQVbQN9dt0tgnbGlErBV
	vOkDT8E2r8ch/BVE6/ffO1Ns4YQp/EUXFpMBOZHoe6LvHIcim0CBXO+x2VRpcRA7XRhOwdzVvgD
	aHufoejLCQSpuvkk1tdBu7rd+wMTcFnLGNX+qMFtI4OwzocKGZxewptggYPeqn1mKN8axqanqiO
	kMy7yZtFsOl/8UdJcIr/LMYckCHj+/X7J70OMbANjmaL+LwkTItKOa++yMTohv/ukiGlaebinjw
	flAXZtNSK+mlEpZ11iXVincmOOc+nkriJdj1X+O5Er6aqA==
X-Received: by 2002:a05:6870:45a0:b0:42e:7e04:e9ce with SMTP id
 586e51a60fabf-468328882d8mr1702119fac.0.1787867069273; Thu, 27 Aug 2026
 14:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827185722.3234622-1-csander@purestorage.com>
 <20260827185722.3234622-2-csander@purestorage.com> <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
In-Reply-To: <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 27 Aug 2026 14:44:18 -0700
X-Gm-Features: AcwNN1UylVUquZ8opNqZqu3tNIHriO6d1S55vB3s5Iygu5DbEGaADAEUlDBXhJo
Message-ID: <CADUfDZoEosgMMQ47BDWBskTOZrYZpg6VUT5c4kwczDLRLXYk=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, fuse-devel@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 1:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Hi Caleb,
>
> On Thu, Aug 27, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > In preparation for setting the io_uring NVMe passthru CQE results from
> > the blk-mq request completion rather than the task work callback, split
> > out functions io_uring_cmd_set_res{,32}() from io_uring_cmd_done{,32}()=
.
> > This allows io_uring_cmd_done{,32}() and __io_uring_cmd_done() to be
> > consolidated into a single CQE-size-agnostic function with 3 fewer
> > arguments than __io_uring_cmd_done().
> >
>
> The conversion looks logically correct to me but the interface feels a
> bit annoying / fragile on the caller side.
>
> Is there a way nvme can get what it needs without changing the other
> callers? Would it work to just keep the existing
> io_uring_cmd_done{,32}() as is and add a separate API for special
> callers like nvme, eg:
>
>   void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2=
);
>   void __io_uring_cmd_done(struct io_uring_cmd *cmd, unsigned issue_flags=
);
>
> where io_uring_cmd_done{,32} would then just be inline wrappers over
> those? afaict, then only the nvme callsite would have to change and
> fuse, btrfs, block, ublk, and scsi_bsg could just stay as is. Do you
> think something like that makes sense to do?

Sure, sounds fine to me. Thanks for taking a look.

Best,
Caleb
