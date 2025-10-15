Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85330E848
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556311; cv=none; b=hEheyXIcb/HdiTfTUsQAAbyH3w1usBMDzwUvszy3jNM4GUTJNC3Is5c+yz+wFk2TpqGnYBK93pQOJffL1j4LW1g0iRa1rzdbr3XaCaTYHFuC64V+pV+dJLMYkmVX38kHFZNFZ0mChgXaSY8J82Tf5WETFHzbBy8qXSx8E3L6p0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556311; c=relaxed/simple;
	bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibYATYy4WbJ+ASe8PDqodU4TIvxD3+4N10nFRSdq5kqofBT7Uhv3p4uFQdkkCFs6jgOjwz3VmIn44xdyaONtu4Pi+sIZ/wWSHOskHF+i+j9vvrBYqcCFxfyl9a+yEi8PDb2dOJf20QgV2UV2FWlizPWOsPxAitYD1SkUvqUompY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA0e42Ho; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA0e42Ho"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-863fa984ef5so1186270985a.3
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556308; x=1761161108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=cA0e42HoUfvW3gVGL6iILHQaTVyX/2HEor6DEKhjyaVcB7FRSv5qHA29OksEfPZqjS
         t7wxBGLxx8ApRZpqC5v1ILhA8EUiN84/+tYTfRCIyIPr8IfGo/63h5x2P/edOFmMYS8/
         DOOP49a1itunEXOlj78PLdKB2Gph4vdk9gmT2h3J5xmtwC9ga6OrGRNf/VCZeMf4rUtV
         lBO1IpexRrtiZLemfbk+Vods/Cq+LpvJFTJtIGTPVuONUhXgCq5pucfQ9ZBqjHklOUBL
         j9pbyGLmAVVWDd7lMM20z18ms32goqE2sMBByxyyuNXPuTGpygfAx0M2mgM9fH5JDkm2
         xCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556308; x=1761161108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=OLF+/SIqBNXpEb5XHDEGs6VryAgyNJVA0mpk7w7gjpddbjfiMNBbhM1DowBWxAXQUd
         XBocxVMs6NLJyjlZv8ZGACG2jgf63u6fPY0MBTN2Go1/8YgePSRF2L+d7MSKa4+DHu3g
         Ji3tNcG/r0etCGvRXkEOuZyLew4HTjXmCCxW4VpFy5lqufVdKexTlkA+pZAtBRbwg4W4
         pdnxFRGpvmPlWL/vAhiTUww4pHDXfdcQYKq7nJGoEY80qFAhqxUMzlejehzpZRQadc20
         wEasbR7jELUUEfWZ5TRZUCMfwVJS+UECgvnWYdg3+9Gz4rOkASZ76A8SCtyvrqjC+9AA
         P4JA==
X-Forwarded-Encrypted: i=1; AJvYcCXsLx4CZoexM8qlww5QRihBRHTRyDLDDEVzTV8gJeUk63Rjd5yFniT2wct5Aoxg0I6/uo4xlpyQV4VMdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypNaICj/Ktd/3Ych7J/JRMqzsVGBBnBxFRu+gMJgxa/i/SFnTR
	x/3AuLNqtBHeC173vzD7cM0vuBeBbyC1CZcMNi6ngbOc6K4H8+vF/luS
X-Gm-Gg: ASbGncuWAQycvUyyU8HpsyEh7qaeev8NzcyweuIyssI9jI8vp79ROa2DQrryv7KdEKn
	gmsG8JKQWCw/UaRkwbGpU7HreXO+IWl/LiS+LhpAUJOXsru6bfUvVcvC+Wyd/rOqow228EA5w34
	aqhZJzn3EtlrhxJXfWS72YtOTY+AuCHAi6r55p/jIfMeQclwLoqOUB5v+Zk90DtqMMiZLNenh0H
	84NrgVeZse6qmuGUvfC6UF0Qd7FYL22BnWrRFFiYgd9USBBRpkUZbH44OoVtcq9c1oY9cPKArw5
	rDzFcL2tBwKloq1AlEqnGQPSSI91qgbbYHYlrAkRok+DJdaHy0krXdx49mBiM9T4cKIlUFMAzZX
	/xRdObJmRLrjX5oDIfs7CdNKYwXsJnpyq+o5rZoT4lc6XJiK3yyjry3mvW7VMrRiZ60B2N/tSGf
	Dnv31aFw6VXlXr2WqPzWag3vHD1Rpmm8pMKJhSN8EprHrRIPQCQRKOt1u9LOgqE/rzGiOtHT+zT
	QDo6jgGYS05HEOzm7fVczTusN7a
X-Google-Smtp-Source: AGHT+IF/CUBVvLt2dkQCDA5YZrHOn4tHGJzgB3mXHJTBxXrUXPaXJyBN4wC5HBKmPT8DqAH/ADgWzg==
X-Received: by 2002:ac8:7f8f:0:b0:4db:aeb0:b624 with SMTP id d75a77b69052e-4e6eaceb3e7mr380441741cf.30.1760556307886;
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:34 -0400
Subject: [PATCH v17 04/11] rust_binder: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1790;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLuOpLGTfFQjBZXdio1nayh5dtiHoR1n54dLy3fgkauJkhueXEntNbGxy1JTge4mrx8nVKiNy+z
 1vw2Aya3HWws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoiding methods that only exist on the latter.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/stats.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats.rs
index a83ec111d2cb..10c43679d5c3 100644
--- a/drivers/android/binder/stats.rs
+++ b/drivers/android/binder/stats.rs
@@ -72,7 +72,7 @@ pub(super) fn command_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_command_strings` is always safe.
         let c_str_ptr = unsafe { binder_command_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }
@@ -81,7 +81,7 @@ pub(super) fn return_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_return_strings` is always safe.
         let c_str_ptr = unsafe { binder_return_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }

-- 
2.51.0

