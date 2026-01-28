Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AF34EEFA
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603314; cv=none; b=XQNdsN+oXJAebHir/jNPrF69PMfwbrXBRtK3hZsi5apWICj4FmL03IJcigMreysMUPE4C4TKnJz/6afKmL4BCxEGj03rjzUVY8LT+a+UD757lDkHmsg1t2BvsEi/KeS3sWxiwMBfn9dc8pquPT1Um4+Oa52r7lY2GLNMXXsqAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603314; c=relaxed/simple;
	bh=WieMihouRH3yblcjYO919ii/575NNtK42r5AoPOiE04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hZyYUgLVkeXGRzhc3dlIEmsqPeXrfMiKLNSo85b/krVIsVEEVxT+js9jBVlWgKIS1sbm0DtIYi+L67Nm2SpvNLW0fFJQTxkpYjRl07GEFn+uUkmeamY9ymIG2FDYWNqbIzt6cmbTGF5PhyLVbCj4jQea90kEjix8qs7qJuso/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dfLMUI+9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dfLMUI+9"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-502a789834fso56711011cf.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 04:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769603312; x=1770208112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkTSOzBpSUcG6pRtvf4q8YShTh5K2XFL4/Cb5Ho1saI=;
        b=dfLMUI+9bYxn74brbHEsn22FygZ3mwEvYbF92Nl/1FSLqrknnXYe5Tz/1Q2CSDzg/Y
         jd8YqPawvKiXFQYpok0J11yNbOABO/jC8h2L230WDIJtd4hkdSqAgZFAqBMBcL/SWfcw
         h5cfI7dgocvChko+mYiy554dinvK5v1Vphw8zNx8efZLf7K3zkAxmbnVw10UH9LKd+nu
         FcNiPpqAB61ozyBdVjpvpCAgConnsIEsXoaNsMHtYEYniWdg3Jp/jKyrHv3ndNDKSOHJ
         nXAMaPCVvhUhHU3KiyuEM+ljNwBNuZybvk61exofyXnBUMNLNMtZdD7Y02ynz3cs3rVY
         85vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603312; x=1770208112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkTSOzBpSUcG6pRtvf4q8YShTh5K2XFL4/Cb5Ho1saI=;
        b=KygLPdpAQJBVGU7QPaoetj0BJ8194opACMZDs3VtN5aW1nQsdny18HsYvTaOFMNzNH
         qt3lipwmOB2eNbspaB4VM6OVF6ZcgXQb9+bH5e9BD/4y11AJcpRGO90iDpH33h9IDpV6
         f2kX2kz3gQRNjKKiFaia2H3BzvPctkVBVhW3VKDG/Qdji7wcMUt0phBHcDJJocwUSH3W
         4wQUtX7gqtyPh6ftB1VZpNNglr6vlQbC2u6meuqZYgAtvcQEBhFe6kBRO9t2cj1OV0aC
         0Na8BRotJz1/VILQLIQtxNEkZKDZYcXwlz4RIowHqTK3stH9ru8U29grnHI5ZjDNHDPM
         yDKg==
X-Gm-Message-State: AOJu0Yxxio9gTrhzewcd6bZsw4NZvJCBI8KBA8MAVITMQclXpUt5yWgv
	9WA2vyv1a99FKtc02O2Oudvfqu3zR02llu7pEzPae1SYolBOF0NQ2p2vXa+qC29w84w=
X-Gm-Gg: AZuq6aLnTzMwMBRIDAV1CkosuZsHMkGQ4aRktZPy78NBzN7QN0hkVQhx3rVrQLkcyy7
	yqWywQ+0HPrEq8nqBl8caEkB6/VYS4moyAxQqarH9SNJGF+YLixRc+6GvA9if3jyMMZ+pIWa+cQ
	UZsGD0tBRQmSEhBbxLobWs1y+yb1CKeeoFQU2PWSMXSNQ5YWS0GZTt+TPgeb55GqAGAtExcd2w+
	BwNKMXGd9+9U26WF6oUUZW3JJljx4Cc+T8fOdeW53yaBzRUEDOiTydQ0r6Ljwuzs9Tr1mpf0QBE
	uEc+ZY1GBPJSpvUb7pM+kQeQvdEbuq8UfUjadDnx2jqJbwOMVwvO/HYX692RAgPi95hyty07cb5
	doaokvxrGZY1HPf4jQoQwAzSFikVKM4zPnddWnO/C9tew/BFZ/iJBd3lY5O5L+w1eZH0ZPqVx49
	eR8fh4OvYQlLn5465KwlnlPGUc9+g+apLB/B0TOie/c/BkSWYOfSYkGgBdICDADq+6kNw6T58Uc
	y0=
X-Received: by 2002:ac8:7f41:0:b0:4ee:42e5:f5ae with SMTP id d75a77b69052e-5032f8961b7mr58945351cf.25.1769603311767;
        Wed, 28 Jan 2026 04:28:31 -0800 (PST)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033a4dcfefsm10974441cf.4.2026.01.28.04.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:28:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260127224704.440877-1-thorsten.blum@linux.dev>
References: <20260127224704.440877-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH] block: Replace snprintf with strscpy in
 check_partition
Message-Id: <176960331041.194901.16439582104055685977.b4-ty@kernel.dk>
Date: Wed, 28 Jan 2026 05:28:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 27 Jan 2026 23:47:01 +0100, Thorsten Blum wrote:
> Replace snprintf("%s", ...) with the faster and more direct strscpy().
> 
> 

Applied, thanks!

[1/1] block: Replace snprintf with strscpy in check_partition
      commit: f46ebb910989a1db244f95bd1f937907591aa2ee

Best regards,
-- 
Jens Axboe



