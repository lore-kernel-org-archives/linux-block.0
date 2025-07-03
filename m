Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13172DE710
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509404; cv=none; b=fvS66Cohr9SMwFBYym92rYmE5pmRg2YWCib2kf5ohvkzBXm7AsnwldzjdvZBApd6RV+tybashlS4uGjCKIF0yMqz1h8NcVwgU86dpWpJb425zrFTZxlnceYgfwDQtoWMMdV3WB2aoPMQ2u93D2LIT9cwSQyS1ziYSLt9RUsLvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509404; c=relaxed/simple;
	bh=sSozdsKNhuQpk5kBHyeoST8ExDgpPsVjco6BtQ5U9oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t//upgpUszig/L7gXJRvghiP77sEuAu/ShhPIlb3Ubx+i5ButrfWHl7Lu1HH3AHW0xf1KKyjkC6Qy1cF/oTY0O+wUHq48RSfwL3aMXCDfY/90k68FV3Yquc1fDK3wVmboG3unzqxJDB0ZaEXyd1dcUDYZ02GSuLEvZqFspIkXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C5z+MXJv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C5z+MXJv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235ef29524fso10466655ad.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 19:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751509402; x=1752114202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSozdsKNhuQpk5kBHyeoST8ExDgpPsVjco6BtQ5U9oM=;
        b=C5z+MXJvYHWB9VRdwxPm8p8XHufTN0EbAiS1Jn9nEryKZUb/sHAhZybAEfzMohzc8w
         k0QU74zoko5Mli+SIfumzu6O6zn32bpJVGbmomOK0YKlNRqJsp2lkHz1+BsQY+INiuCx
         z36Dy9jVsNi/NbYnu/PpPRvAB5p3TAqV/6m4QTOmFLG5XI4LH20BYmkIDO4wQm/rvK+e
         RXdS7DFRnBDVdlm15nutkLBmM4mT4AmW05MxlFQyir8y8asaigEeF2wAPgOj7Cxqe+e0
         FcU94USRRCNP/nxO5rBs2eWv7uiXCA9TflqvcOBktA96VMrpOzZCjC0qQUIz75dO6u4H
         +79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751509402; x=1752114202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSozdsKNhuQpk5kBHyeoST8ExDgpPsVjco6BtQ5U9oM=;
        b=KVKSe4Ii5qDyR0tCKGNv2QnZugJ8UgvXGD4tiMWS4E3txnX840FTX9lHO3WYzkB2tp
         QCgRbRSzN9rPFfQbqhxJh7lTovKMltQ6foUhPyJGEoaJI9ts2L2HJzYIEA9FQJjYEA22
         xDcdVyKgGmmFAVh4hne2exrbF1muU0DSgjFNilYCwkeAaDZxazgHrPHjkOqkdPrtzoa/
         bKeaL7MAwrPndm1VKm2zMLhxdVg01BB94mDcC/mXHetwqGO7LcF7hqwu+JMWI64KCZRc
         yIGq9ylBRKHSn1Pl9mxwf5tSkcEW99a80hnSTTZ8MJNJs5O0wpRt2i5Wtddxmho96PiO
         YhGA==
X-Forwarded-Encrypted: i=1; AJvYcCUaEYiU6n7q29KAb0zvd8WyDypFBf4HNbuX04nhnUaujEvdWuIhyNdP1NNPryuU1Mu8LsD99lakwTsb7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Uz+ASzLi8ARrrkYtKMZcx3MyKzSKFi2d+UQlnv2C1XAU1zPH
	p6JvHJU8H091VLeTvqYWhlbgpb1rkV5YqCgB1Eu+9U+ak1xbtAzgC8ftnNu4303v3yrZ7wLbJqg
	JUocvuRMrwj8C4nBEYzR2vqiaGnb8zzbqZYfse9aE6g==
X-Gm-Gg: ASbGncsTwLJLAhFyuxlT9IdCgGY9VLf2m3eEYzwqqoPXiRYqr4RvIcj0SMwYq9mRUmH
	rPABCYsI5jVbihDmlnElh6wF//XrW/kUyLxACX+c81Q81j7ol2qMppE2uqDAHxUfOwfSWtnwcWM
	Vi0dYcZ8vzqBWm8DsY6Vyh1kQxkVFn4D/Jnfso2DI6+w==
X-Google-Smtp-Source: AGHT+IETGcw+sDY1Vxn2zZxvP0Se0ropGzlw1pukwizc5cNMwW/3ffNGWNdpZs7owQmMI5rs731eKwvoGUeIxw/NGVI=
X-Received: by 2002:a17:902:f68f:b0:234:f1b5:6e9b with SMTP id
 d9443c01a7336-23c7b317b1dmr3448485ad.1.1751509401926; Wed, 02 Jul 2025
 19:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-2-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 2 Jul 2025 22:23:10 -0400
X-Gm-Features: Ac12FXxdY0qsiKGDsezvVNleVJOeRhynp6mkZyyTW0xhGcjxftVlEh7BYJla2GI
Message-ID: <CADUfDZqwmNJXst4ryHr6Pft55eDT3NqZ03tybHqZ0adV5RdLbQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] ublk: move fake timeout logic into __ublk_complete_rq()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Almost every block driver deals with fake timeout logic around real
> request completion code.
>
> Also the existing way may cause request reference count leak, so move the
> logic into __ublk_complete_rq(), then we can skip the completion in the
> last step like other drivers.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
