Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABE421A00
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929888; cv=none; b=m6UZf9Cj6RDDr1XqZfbbx5iTEWGRltfOiZnPafrBXGQmi3qYDiZQCsLQj9Kvg35rkgO19h+FqeCk+m8BzgDPeI2fjoYK9BHJJvJAlZUvgqJi0SscgTCrhYXi4mUrcH/9vlM56FulOBfdjDYTj1nXX+5m6xHR2RdMnlAP92C753c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929888; c=relaxed/simple;
	bh=HbRg0byu5nrW0iLoW8OhS4h1+C5q2yGKNLxrw3RQCaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPCbDe2SSOHcXPWcIkgoMd1Nglf0Rrtd060q5oCrLI/HFihgxq35393hLh9gZMpBCnIEBi433zoqW/QuQWZO/gh1QQV/QJt0rnJiKPtN2rNZvux8shJ1ZUfXnab6PY1XFW1iUF4YMryvWQsroDFTssKbWgXirzGTwNmnRBiNTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rjdl+ySX; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rjdl+ySX"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c6ac42b91eso443682285a.3
        for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 09:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768929885; x=1769534685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZTH3ZTdAE82r7lemIxd3d7ZZpxLSrkE7KxsaG+oA5s=;
        b=rjdl+ySXVxBZf4BxH7jwJdcDVBioiEjzZTkwel71Aa2BMgKsqh0cVxfUK9mpYDLiZU
         qDbLXnjyFDv9W0KQLrhE0fVvlv5XUfdOcHJ2/3oWAYd5j1pSTsdHVtJm7Fk1Za6tKwJ8
         KHpbdMiqq7+5xOcgd3qxrEp3PhEs4N3YWbr+G4B9A+J1JruW/Lz3Qq/VjyZ8Av5Z/vg+
         p9jpPo7/lNEAs4lV6eFwPCEcHQ3tOOzZCllfDoAaWYjmmvC3LHaWVvmlFN2jX0tOxK4k
         kNbw8Q+NyzF9UMBenak3wknqrOZhDEMNl2xc1pipOUswKbIyFkPqMg1YCWkYCoj2uq1H
         NqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929885; x=1769534685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZTH3ZTdAE82r7lemIxd3d7ZZpxLSrkE7KxsaG+oA5s=;
        b=WPFCXt10lvUYXTjz1SMh8RBk/9gNhBdtLFI1Zw/kWgbbyk/RJKQppdaPcf6OSRkx/t
         hZC3IJPaZHbnseFQ6Xzpt+K+Wo3LAogWlkbuyQSRuceAZY6BY2koNZgxvJzWJ+2jpxwU
         OvLKrIILQtmDpLoORXdJIefQlnbLAaCg8j5Wue2HRKnhyWDdSOS3j7LsRNjyb93PlMEf
         GFuekpLtkS41SyskCsWEmuJbnLPokdbbBIVy0dFpx1WCghPmzkuOixFs0yR4gt+V4cy3
         hrsTyOb2t6RJa041Y0cAEgy49JcS2OFL6ti4ERQWO4bQwo3aFoVAv2SGuoPrODWm4okm
         KIvA==
X-Forwarded-Encrypted: i=1; AJvYcCXHjAiUqnB9L7TUhSzdtuNCtXXrHROT9ODJ6oDeTQYYa/5UWfGXQrrmmRF5dILovJ7hNPP9JuzGiw+DvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyPA6DGO9xj1pnTd5hZeRIXw2ithrgK7YoecPgBd+jHXoIFhy
	ELVWVrjQmJjQ3hZbBx5JvpOjzLyrhvjAvGb3MVP5tiYNPtMubj1RlyC7KXNvxZOObL8=
X-Gm-Gg: AY/fxX6urtO2CNZwWHf92h46VLb6yEWTYkgxby+QiIDaMVPsZEuYRobkDujATiNCB9Y
	qtb6FH6DLPpZ1GXva8RyCPsYbOh5hQNC7eRRugorRv2Q+UI9RaV7vktQrI3eN8nNa1+LIzuD/NM
	aazbXPeSVP2MYA5loV3kui/+MsVK4Lrdh1pLMLEBsFgVPVIh1/94Ur8TDxIBYlGn7IvATRUjAVC
	MBDxf1VOUi3pYZsLPpYfxOqEnc5LZo0ytBxs81IQ+Htw5QGllxWGDVu1/pFxw0KQeA+x08n5WnW
	UkHyjLahFXRlSWIMKozUVuWHWDyKXXw6Xxdq+w/YH/7Q8TxOUqgffW6M/cudB5RWl2IiKXJCwFD
	A5SXOh9u3ee+LD7KVR9Vw7dnTXIlLfPSEZ6YwphN7kZenPoe+mOqp1zHG90qmeUqLCR1p+0QTJM
	E4U+EjCrnu72svQuW9ls6RD1fkbDH1CQr5waCVuHHl4YkbdoZcSV/n66zTk0/+omSBcTF9
X-Received: by 2002:a05:620a:4054:b0:8b1:110a:e14 with SMTP id af79cd13be357-8c6a67648cdmr1965912185a.55.1768929885180;
        Tue, 20 Jan 2026 09:24:45 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7248dcfsm1070802285a.25.2026.01.20.09.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 09:24:44 -0800 (PST)
Message-ID: <1b983be6-ae2f-468e-b306-3889d0b78553@kernel.dk>
Date: Tue, 20 Jan 2026 10:24:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20260116074641.665422-1-ming.lei@redhat.com>
 <aW-2Q9Zv_UNX127Z@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aW-2Q9Zv_UNX127Z@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/26 10:07 AM, Keith Busch wrote:
> On Fri, Jan 16, 2026 at 03:46:36PM +0800, Ming Lei wrote:
>> Hello,
>>
>> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
>>
>> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
>> context, and improves IOPS by ~10%.
> 
> Looks good to me. It feels a little unfortunate to have to add this
> parameter to the callback just for this one use case, but maybe there'll
> be new uses for it in the future.

Yeah I agree, but the win is large enough that it's warranted. When
I originally did the task_work fix it was on my list to investigate
further, but the bug was such that it was better to get it squashed
first. And then nothing more came of it...

> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks!

-- 
Jens Axboe

