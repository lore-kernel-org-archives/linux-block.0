Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C772F12CB
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911376; cv=none; b=dTT4VxojGyUv5W27i+Apb2W+/+Twq1Rz/weXxkO2kyqT5NIMFjASHWXzLQnuF14AQTlAxqMC4A6dNbVX35AVTKq62AsY2BN9kehJufZyWUs+hODshe2T4lthoE6uT9WfKblLODLcUsZYU/qYS5vb+IQy4RlaYAyPuw4JMqcDty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911376; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2sN07c0Td32ok6+aNGPcJXHthu6JNg0unjJhwHB1KwyIRu+SPaBDzMbEsrDJ0C0ciSGIkrY1vVKp/71TmhfCFSBGRZk5wNS0RkoeyUOCoYHOy/Eqn/85DlUReF4Y8Yn7lx91j0e+wOk/+Eqq3RRq0yoDvohVloc6mvWAtPHCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZZzOKAO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZZzOKAO"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so5547782a12.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767911374; x=1768516174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=lZZzOKAOryflGkHFHXLhWEwFv1Z8ob6eI0x5OznkMFYBsvb/gPm9KQnkzvcYOHAODV
         7lYRnPZMoxJ6bclWvNHtkHwcl7CbYQ+dMvbQNkCjTfnj8gJ0UD8eL/vWfyd3WmAVmXjt
         xCFAdqTEWdf7jZS6euvt7PcXUzgP1TH64jUvBEdGyUlYujCWmuD1e4UpJcwj5fOrglYj
         41PjUOnWOivZZWwlU7omJ3Fy+qU5/d/vuXIrc6Vyf/h5n9L3PIG7S7Dy2ftgj/TETDdF
         cX7fTAd7I5RMBUETr5qpfQhzaiMm6IERRiyR/1PxitfwlGUG/up45SHykjKB+QCwyBZB
         hFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767911374; x=1768516174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=te3pcie/Wrix/SjwsSHa81pnIDFc6krQSa7Uay96lp4lEhdEXVdeXDKouB5/dgBJ8I
         oztPAZh4OnuYeC4RuTpqAghiEP3gdW0AR1w6+R9AjUKGTgr6xiwUpGlGs3oq49eOA0gv
         21pt9yyFQBs3+kP8BJBohf2iJkyTzyVV053LTMlp4iyof4yNKqJ45yU4o2tjtN7+HX87
         HLkqBTiU19sW3cA1Y9fs/evXhbCxkSsON7o6nLHx6JiXsVjXvo3WLmkeaVlsADWWTSfp
         PCvu2fSGzPdZ35OcaGACF3EGv0j7pmR8dFLDYJUDHCT+Vd2kDmZGo5WocqjtYyHmC7+b
         xErQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa38u14KoZgzXuwi1AMZFZhaSupNO/3oovgc8g3mw8gIOM6voO/tLaJchSqAzevX+moTW+qcVMM0Ut0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YydedHLuKBj/htxAKUB0aEOjpxVK+cT3N5WsNSNtt17R7KQM5OF
	AiY4eXPEamU48tK1ILw5g3AfAIpts8NjPxVTlS4GjFFwG2OGHdPZotEdQzEhEgNnzaepCEzrwxj
	hhpdcPXU+H34l/rnf7pPVfFiu8RQMqHFzpUk=
X-Gm-Gg: AY/fxX6F2ttHoqV8ZBP305MkLK/6YWGZvzAXVms5XshffmW79rMaLg/xXecWDwnw5sc
	9X9kcHkgiWi9JVFznUGejV1c5EDL5KflFTBqeT3sy+kgm7bWaqtU6f2T0rHG7mmN0uuYfK2kWuu
	Idz9xpGFTQrC4rIVjMAypnafSn8lGmzlw4G564HyXsld+Xl1hvWhg0MML4nDqaKfl9jDmKxswme
	71rHk+V1KblVlcDeT2bFnabkbRe9P6OJmqazqUFvl9bkGU2JGGxKWmNAjR9lpr1h74EdBUWGiCh
	WXU5OVszyrBcDwvlI0jHFdbz1ZN8szlRoy3IoNK/qOEFkSK5Oiar
X-Google-Smtp-Source: AGHT+IFq4bOGs9GiaDPuxrPkPDQqpH6O99jmfKArhtNyjfH0z8oAcPAHNrB8H01RfSsKirfY4YVS9gW9Yvi+snwsCl0=
X-Received: by 2002:a17:906:9f8e:b0:b77:f4a:ca1b with SMTP id
 a640c23a62f3a-b84451c0394mr747464066b.16.1767911373375; Thu, 08 Jan 2026
 14:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108172212.1402119-1-csander@purestorage.com> <20260108172212.1402119-3-csander@purestorage.com>
In-Reply-To: <20260108172212.1402119-3-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 9 Jan 2026 03:58:55 +0530
X-Gm-Features: AQt7F2pAAFSOfUmefCeA2vC1d6w3uQWkJed67PiB2UbrrV_yifcAdj4Ne0hFs3o
Message-ID: <CACzX3As4XC1y9RDYnJzkCW6nWb46tPONFox9uCAxWYGo_kAO5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] block: replace gfp_t with bool in bio_integrity_prep()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
