Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFA1A265F;
	Tue,  3 Sep 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400398; cv=none; b=n9umDn7BjGJVG9rd0bO5SEoThxfgvm7Z+Ul3EaAnoS/T/0nxIlCuHvC3pTbt+ZGJxPm75nsSwaZ4qJpdcuxr31K461RVe2Y+lzkUTXt4JGp9p3mWOa2/GsFbBqgqgdxiY9YBTRcRrwYJ2e7FLxai9fjb79ELFwn0dv1XgmE1OK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400398; c=relaxed/simple;
	bh=FrRK8niBF91VUDCobQBFSLRy3tmazlR9yYqElnXTmbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhlCnQIMVDsn5WhNQWhUz4VUG/AXjisvX80PujDR72q3+3UB/nHSJjx10RnsZQdspnML5Cro54fuuHXtrWjH3KKUurCn08gViyZyj2U7LvilH7EQIRKLlypKaFR3xtdKWLUPnP7T010E46eVJ42K4ruaMbU3+L7lTvaH8/61wW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkmpREx8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkmpREx8"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71428f16b09so409576b3a.0;
        Tue, 03 Sep 2024 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725400396; x=1726005196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kuW8ixJYbgv1qbPGNDxkO182aNeF7uYIBZvxbF3D7o=;
        b=YkmpREx8lI6MiEcxhbi15h5qZSoAN94ViO/dzPqJMfZHKxYVcGqcNu5XlZ7VieZ8I0
         RkfHVLXDxoIBFP8tNkVOqbfKxIjBhNd0K0FbVFagJq6kvnmz9pHNIkbVTq1yIZZzB9kX
         QXNOmkxaAmeiPNS7WsmN0KLuN44S+dQ+pRPhSEKM6Gtn4vXCxirwjci6/cyBflELJSOS
         zccNACCyFId0XsiWFabeinm0tJya+RcNBmBqY1STtaB6wMuJrnRzt2UZ/sTLgObekNkU
         46TO3qIix2VPVHCdu3eIRO2gsP/2TJ0PCeDmT/fPuZ73feDFub0zngElmW6j+GCmVa7p
         0RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725400396; x=1726005196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kuW8ixJYbgv1qbPGNDxkO182aNeF7uYIBZvxbF3D7o=;
        b=mmYLvrq81GThT7p7FwzyU5btzImFm/43yZySy2HgTtV+mfR5IB6uyF/GYtgmIb/uHX
         QUhQs2xETe9UMl0c6lqyPc9B3s0aWLCp/w+IqCM3o4G0jvSXbC2uvTjpggO4J5QvqCVH
         6b4dAaC6Qf/DGznMbrNig4m0CmQ/pWZ8Lb3qxrM/fGR9gABvz6tY1nRoVbpyof3t4F8n
         Wo1PRm9oYg6ZvZDPgZxefzMHQwuciRa/ovajPUdJUZ0l2Fd2c1Rw4ygKjA39HkHoB6V1
         GQgtpSUOf4jF4jP5BBgyae/JQI64O+qq6zVR1XpBF9b/hOSwfpcM65VQaMvXM1KzxqYl
         7s8w==
X-Forwarded-Encrypted: i=1; AJvYcCUZWCxieN9ykUR4M4xnwAr6KWw+vbG1imQAQxnPSHn0NKT4gsKvn8fsemJ8E8IQzU1Ofq3DymKr1RxCHg==@vger.kernel.org, AJvYcCUcdaSvgYTYmaGuLRPq0zkqLBvBj4OEdEvTdbMZPijtep5TI6xg7vJP2N8BFK48s2fgwgKsjpGRI246Kc6d@vger.kernel.org, AJvYcCXFwEPbzmQ6quHzo1Muo70IkKr0CdVWMUhHUX03ppNDZbyxBhf9o5Q2vcgi+xGe2aRdXGzQklKhw3b55OxsQx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSm0vS8QPwyCJoBIS0bGL8XoeqNI3nicXEumexHa0rtMzsnMxO
	ZZuCzT6L/8z/NUp9X7+xEsJmJ5AkgJVQ7+SYMAWnHcRnuHVnFOgmRGB9KAItQyC8t/4ShUi/UHJ
	gtlOaQCNElkbdq/N8lO4Tr6CeqUo=
X-Google-Smtp-Source: AGHT+IGbogrYJMR3ncTVQ7aVTJIioULm6HG53lnWgMJIZ8pPc9keVi+XoFBlQSVG2OFGIYGRYIHbaowMBcmbeFqAPYI=
X-Received: by 2002:a05:6a20:a125:b0:1be:c3fc:1ccf with SMTP id
 adf61e73a8af0-1ccee3aa41emr9530103637.2.1725400396307; Tue, 03 Sep 2024
 14:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903200956.68231-1-a.hindborg@kernel.org>
In-Reply-To: <20240903200956.68231-1-a.hindborg@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 23:53:00 +0200
Message-ID: <CANiq72=NhbfKiMG2iUOsNT8acZAadRNeTAPEJKRPkmYq9w2J-Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mailmap: Update Andreas Hindborg's email address
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:10=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Move away from corporate infrastructure for upstream work. Also update
> mailmap.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Applied to `rust-fixes`. Welcome to kernel.org! :)

    [ Reworded title slightly. - Miguel ]

Cheers,
Miguel
