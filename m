Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CF40801E;
	Wed, 12 Aug 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571625; cv=none; b=bkgYARdG5dNs/rEP+UfoUCmf2GTo1JU7YFM2aGQYT2lXygAVASncc5nVhFpv8tGzIL6NfX/MMmGJStnwF1379pKfW8AWulmzuGEjozwf7mPpZMDAHrmOYPzWYr1gXlPC83TRFw+1rmlyhJcvmIPuvAp77+YR+PRfUeAirO07m10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571625; c=relaxed/simple;
	bh=zoOEOQ43+sDxWy+UnOrNn2U9dUnrZIIC52tkbdcIiuY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mMcG0vAz0Itg0Ld07aoICQSsSbD2KTLExaFc92QeWnvu3WBUnf004y+y+TqPjwRHwSfVpMZFHWaecXBCqib/2r8f2wRgfLOxQQraQ4PeHduTgT17vJD3Q3VwGMTzgpIcANI5IF1AJG09W/AR2PQAbQSwm0lGzlZlqsqwM+uD2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXsVTdQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXsVTdQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987811F000E9;
	Wed, 12 Aug 2026 21:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571623;
	bh=6nEU+aeRluycxdNo/6s4mZZKrJ1RxjlgPtIHRp6CvKk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=IXsVTdQ5zQUuKR4Iw6ZK3MQhGzcBbD5D+BmAgP90RIhowNF15Qvl/daAVQJt8uLyy
	 rIkJAZ6sNBkDjUGtU3cI/VGEiGebXer+9cErer6IqhdmgixYvy4Hz1W7Q7pabBrv8x
	 YQXaZcdMYk+oUEFaZT6hbmwff+KV39BTSqdgf6+R+2uOUvAmAbz9PrPAOS6WKy0Fa1
	 O6EgPhBJzHIifIXXh8zwYLZJluIm96rhQ3IQSP1gu3YzsVqWyoQ5I/w3Dm6bN1SHUD
	 PeamQtayFym7qz9Jcw3jlL3cOB+eq9PY/6eF6heTF+y3ojTLfgHj8GMUmuJum26dfp
	 gSeZSwkGxdiXg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 23:53:34 +0200
Message-Id: <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
Cc: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Mark Brown"
 <broonie@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
In-Reply-To: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>

(Cc: Mark)

On Wed Aug 12, 2026 at 6:33 PM CEST, Miguel Ojeda wrote:
> On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> w=
rote:
>>
>> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, thr=
eads it
>> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates c=
onfigfs
>> and rnull to use `this_module::<LocalModule>()`.
>
> Applied to `rust-next` -- thanks everyone!

This series has a semantic conflict with both the driver-core and the drm-r=
ust
tree:

@Mark: When you merge driver-core-next after rust-next (which I think is th=
e
case) then you need to include the diff in [1] into the merge.

In drm-rust-next the build fails with:

	error[E0425]: cannot find type `LocalModule` in the crate root
	   --> rust/kernel/drm/gem/shmem.rs:628:5
	    |
	628 |     #[vtable]
	    |     ^^^^^^^^^ not found in the crate root
	    |
	    =3D note: this error originates in the attribute macro `vtable` (in Ni=
ghtly builds, run with -Z macro-backtrace for more info)

which is because the kunit test in rust/kernel/drm/gem/shmem.rs uses the
#[vtable] macro.

This should be fixed up with a patch on top of this series in rust-next.

I came up with to potential solutions [2] and [3]. I think with the new bui=
ld
system we want [3], but I'm not entirely sure this works correctly with the
current build system in all cases (at least it did survive my tests).

Alternatively, we could just open-code a dummy module as in [2] for now.

[1] driver-core-next merge fixup

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index a4927452016e..17ca504b7f8d 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -87,7 +87,7 @@ unsafe fn register(
         }

         // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
-        to_result(unsafe { bindings::__serdev_device_driver_register(sdrv.=
get(), module.0) })
+        to_result(unsafe { bindings::__serdev_device_driver_register(sdrv.=
get(), module.as_ptr()) })
     }

     unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {

[2] Open-coded dummy module

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c04e6c5aa7e0..274924cfcc05 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -157,6 +157,15 @@
 /// Prefix to appear before log messages printed from within the `kernel` =
crate.
 const __LOG_PREFIX: &[u8] =3D b"rust_kernel\0";

+/// Dummy module type for `#[vtable]` impl blocks within the kernel crate =
(e.g. kunit tests).
+struct LocalModule;
+
+impl ModuleMetadata for LocalModule {
+    const NAME: &'static str::CStr =3D c"rust_kernel";
+    // SAFETY: `try_module_get`/`module_put` handle null module pointers g=
racefully.
+    const THIS_MODULE: ThisModule =3D unsafe { ThisModule::from_ptr(core::=
ptr::null_mut()) };
+}
+
 #[cfg(not(testlib))]
 #[panic_handler]
 fn panic(info: &core::panic::PanicInfo<'_>) -> ! {

[3] Allow module!() for kernel crate

diff --git a/rust/Makefile b/rust/Makefile
index 48adcd9b7851..4f6bf1b4d194 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -279,6 +279,7 @@ rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pi=
n_init_internal \
        +$(call if_changed,rustdoc)

 rustdoc-kernel: private is-kernel-object :=3D y
+rustdoc-kernel: private rustc_target_envs =3D RUST_MODFILE=3Dkernel/lib.rs
 rustdoc-kernel: private rustc_target_flags =3D --extern ffi --extern pin_i=
nit \
     --extern build_error --extern macros \
     --extern bindings --extern uapi \
@@ -351,6 +352,7 @@ rusttestlib-pin_init: $(src)/pin-init/src/lib.rs rustte=
stlib-macros \
     rusttestlib-pin_init_internal $(obj)/$(libpin_init_internal_name) FORC=
E
        +$(call if_changed,rustc_test_library)

+rusttestlib-kernel: private rustc_target_envs =3D RUST_MODFILE=3Dkernel/li=
b.rs
 rusttestlib-kernel: private rustc_target_flags =3D --extern ffi \
     --extern build_error --extern macros --extern pin_init \
     --extern bindings --extern uapi \
@@ -386,6 +388,7 @@ quiet_cmd_rustdoc_test_kernel =3D RUSTDOC TK $<
        rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
        mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
        $(rustc_target_envs) \
+       RUST_MODFILE=3Dkernel/lib.rs \
        OBJTREE=3D$(abspath $(objtree)) \
        $(RUSTDOC) --test $(filter-out --remap-path-scope=3D%,$(rust_flags)=
) \
                -L$(objtree)/$(obj) --extern ffi --extern pin_init \
@@ -788,6 +791,7 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/uapi/uapi_generated.rs FORCE
        +$(call if_changed_rule,rustc_library)

+$(obj)/kernel.o: private rustc_target_envs =3D RUST_MODFILE=3Dkernel/lib.r=
s
 $(obj)/kernel.o: private rustc_target_flags =3D --extern ffi --extern pin_=
init \
     --extern build_error --extern macros --extern bindings --extern uapi \
     --extern zerocopy --extern zerocopy_derive
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c04e6c5aa7e0..7df9159788ad 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -154,8 +154,21 @@
 };
 pub use uapi;

-/// Prefix to appear before log messages printed from within the `kernel` =
crate.
-const __LOG_PREFIX: &[u8] =3D b"rust_kernel\0";
+struct KernelCrateModule;
+
+impl Module for KernelCrateModule {
+    fn init(_module: &'static ThisModule) -> error::Result<Self> {
+        Ok(Self)
+    }
+}
+
+macros::module! {
+    type: KernelCrateModule,
+    name: "rust_kernel",
+    authors: ["Rust for Linux Contributors"],
+    description: "The kernel crate",
+    license: "GPL",
+}

 #[cfg(not(testlib))]
 #[panic_handler]
