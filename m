Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF31EA7CC
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766251953; cv=none; b=KRKU2YFjcOspwA0OGMIY1B94dEtPxvPkU3L3wdlxb8Nf+cOG1vCY6/Ixj5B5qSnlr6xPsm17Klogrvd8QTPpOd9pbpN8/lvL0v/Eiu9hno6yiFzIDsNzzggayZMLa6dwd+dTZzdWh7L0aXXS+L+fA+K7caUQceWR46g8A8s1+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766251953; c=relaxed/simple;
	bh=nBdYmX8I9PRPdvnvBha5bJMlQMxxN+gbdxxLnaxWK4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Azxi5Ow2uq+leY+MpQDBZvl30/nZGcDTyC5tdJvPyaInzcxmSeIOM4ZrMwGdEGpgPq1HfRQFxZ4JhEdw5r6cD+aaLPK8b9ISuUDVx6b/Fe1as3kJJePeM49woRiqeocYf8SC5DFcjlDNNJnJKp2zEmG7cA+6T2tPRZzVNB6txd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj/ycP50; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj/ycP50"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9412edb5defso598222241.0
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766251951; x=1766856751; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBdYmX8I9PRPdvnvBha5bJMlQMxxN+gbdxxLnaxWK4k=;
        b=Hj/ycP50iSKmMF6G6n3Rzeuo06Pgn3Wc6hEr6yKMpMdzGWnOEvw8FSpAtYUyUSyMsq
         23EuNcG9C3apFw1n3i4jAQCcrlmw01K0+CCR5E/0ytP5SN9QNpB7qupyOl6tt3UwPbJt
         VlJcO0gh9P8QF3ROeWU23MCRJtx/GQT+2qRDGHSnHmJLKRMNAO/Rot0+yuZ3biWDzD9J
         7hKN30SgwbVjaOByh4/TrsEvBQEpyIGuRdCzPiNcX8oGpwu7sK/iXUNE7mlfBN80zd4/
         Gwwn2KO8QRWQR5rdjehm9Qi0yCZAGrqIISloIgovhDv9188wJI4/INxjDnA10MWLCPWC
         9w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766251951; x=1766856751;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBdYmX8I9PRPdvnvBha5bJMlQMxxN+gbdxxLnaxWK4k=;
        b=fcVbNybkjZ5bx718NjMeU3uLltEuxLBnqRV4QsEBR/y3btZyLIVCfOMlRWNuH7pjYn
         25eL4N8Jjyus36KVs6OTMplmFoqcHio9FYzOIZj2aNUS34S8eFOIoFiwyBr6nxpIZ4lJ
         cJw7FhxGltprkJXJs252eF6llExSewK4vjjDhJtICaTYu2xGuHL7eHScQqtv7Ci8nXla
         P50eDnrMkrMxjq+7rejnSV/ZPbmDOfpiTQtCU8ctUGcd2LKNUeYjJq1iTa3uXVgoLKJZ
         aH7+rJmiRu5tmQUDTWBxGoiVUCrNgj+w5x8enEgCaXSHmYKHa74LGcOMQ/9FeJEgVYbg
         wSiA==
X-Gm-Message-State: AOJu0Yx090CbwqtmaGWAwiZLomA5PNXRBzLy/gx7VV5PDz+3TShgaCIZ
	ya7+zv9O515JJ33HVH6liDj1sKJ4pbdt+hNO+yEMvieca6ViPAgLlO57M6eZN9lzXSLNdW7odWM
	hdCg35DhfiSinbstfjZKFqb66H0qajwZgcohWmVM=
X-Gm-Gg: AY/fxX7mkXm3TzSfEtw0QnaJ/Ha7A0UpWsDzsoEVcFlMCO4GOBldROQnJgE8vNuNRo7
	UAQ9qSV4qPL9wHZal+4292wVB3hz3stBPM8umQJySxSSrp+wfsUFdX9fnUICMLwTxmUmiajXV0M
	OJG9eCzS/IKD/Jz7GOgPz0sOJ5aS8vpalAs70c4eMkAoSmUqnQP40dvRt2CMO8oeI6PWsaEIQZ5
	UK68nD6bGgAhgE59ABTKYYtkzxrMXuimW3/vlo76a+edywl7G9IYS+mRlMMqF+y9+isB7pCl02a
	Kh34x6EDTWo+YfVAxCffiCI27KCKkfLyPkDnEHc=
X-Google-Smtp-Source: AGHT+IHuJgs7hKhtD/ctzqKH0dugT2Cl4KosgGGegiv6KliJybucs3U1n/6A8Km14jqvLEEhFQaAk7nyQcwhkNi8cG4=
X-Received: by 2002:a05:6102:5107:b0:5df:ac57:b0ea with SMTP id
 ada2fe7eead31-5eb1a641acfmr1904293137.10.1766251951106; Sat, 20 Dec 2025
 09:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220153307.56994-1-vitalifster@gmail.com>
In-Reply-To: <20251220153307.56994-1-vitalifster@gmail.com>
From: =?UTF-8?B?0JLQuNGC0LDQu9C40Lkg0KTQuNC70LjQv9C/0L7Qsg==?= <vitalifster@gmail.com>
Date: Sat, 20 Dec 2025 20:32:19 +0300
X-Gm-Features: AQt7F2q-vXCY1qViQYCjG6gKqXhA9zNic2YbXSUV0291pnKvG-b5vg8XNTgACLc
Message-ID: <CAPqjcqr1dXzoa9BqS8UfR-_Pz+M5A1WN-Uo-T3jxZQwu=TODCw@mail.gmail.com>
Subject: Re: [PATCH] Do not require atomic writes to be aligned on length boundary.
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oops, sorry, is_power_of_2 is also an incorrect requirement and should
also be removed.
