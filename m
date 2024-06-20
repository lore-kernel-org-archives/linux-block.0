Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9D1AED4D;
	Thu, 20 Jun 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897771; cv=none; b=t5KgGvhUBllyVB/vWr2LVri1n7m4cwU4yyTFGxwtiXuvUbfaiMZsgz8xmo+s0xi2BVYkIWY6dE1aIEG3lmjvH02YtmxxdZLbMNQSo4FOxWcZMFEbnbStPaRiQpdJQYiurKsXXaqGI9I4jlvwDxS4kttGMnqiiMy7hK5k+w0vO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897771; c=relaxed/simple;
	bh=kDDXcqhifdQ0fs/vCmvlUw45BhHCVuzx3zFGWGlt0K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V9OhBjmUal5IkCOv91EBe78fDOLrmpXJcly08XJbS8lJWlczkWif/RL84O//jU2wlFNAzdayLdVKHnnICpsoPr4RzS/xKqnAIE2hzWawrpsWllTBqbI1jzqgO0rGnybd8pI6eeBoP35jXaaiFpDlyjwB2rOjgXtrAT7vQShxI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhKkWmLG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjVW9Jmb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhKkWmLG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjVW9Jmb"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RNQWo5IwnleQTCW7ZS1Sz2oq06SzzX0D8BBq0XEiYBk=;
	b=rhKkWmLGbRa7otfu3MM/yrgzaXwmx9VxOMRNuzE/7K5sugdZiTxyqRqYKhcQ/DUX8IE0AC
	jeE2tdcDj9gGEzKXkH4TLX6aBh5SwmtbOu0dq43sNFvKMAMjjXrvddbH3G0BPKisqO2z/w
	Iyy3prJ8BctZb/FnjEWbGNvNLhV2HLRmFuOfrsz5n9ScMJp9Mwye9wTLs7iwQM5qMrIMXy
	s0HoobY/ds/8bcv9dN9NXHYLQ5lSiJGw6tunxLeGaz00BU2P7znguoHusUd+mspphUpEwI
	XhJiDrNAernMC7rqLeAUtG5wyP9JExnyDA9eM8PRtz1IIU9cB0yXULO2SN1PUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RNQWo5IwnleQTCW7ZS1Sz2oq06SzzX0D8BBq0XEiYBk=;
	b=TjVW9JmbN1Zd/MajDsDQHkaOyJC29or/wkdmyUc8QdBVgngM6On85xzW77fmjDgBYsOwtr
	8YjraAaCZd4ze3CQ==
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [PATCH v2 0/3] zram: Replace bit spinlocks with a spinlock_t.
Date: Thu, 20 Jun 2024 17:28:49 +0200
Message-ID: <20240620153556.777272-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

this is follow up to the previous posting, making the lock
unconditionally. The original problem with bit spinlock is that it
disabled preemption and the following operations (within the atomic
section) perform operations that may sleep on PREEMPT_RT. Mike expressed
that he would like to keep using zram on PREEMPT_RT.

v1=E2=80=A6v2: https://lore.kernel.org/all/20240619150814.BRAvaziM@linutron=
ix.de/:
  - Add the spinlock_t unconditionally
  - Remove ZRAM_LOCK since it has no user after the lock has been added.
  - Make zram_table_entry::flags an integer so struct zram_table_entry
    does not gain additional weight.

Sebastian

