Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6B27FD64
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546190; cv=none; b=ZYNioCn02Rt0dtLbH+gAJQJEIzvQ/pMVsPKZ5UNrwa6bRusGs6+PqzVr2M61j31DNCWXcsfLnX1OunhxpFpSEukVdMC1UrgcbS29sZcZY/KvYGzZqf1BOvSksD8Wt6godx1VwzZoGCc8WWLIX28iXd9V25124FUaCRFW0UHC0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546190; c=relaxed/simple;
	bh=KtBis59073/5z5OHotS5cslDoKZ1kf3mjXDdahsqRQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TG+BVkJkygFfMtcHAHXO8LciFN1uhAiScBCnPDePUNLLk8BRzCRbXUdjEwXi78nEg1Z81PD2zOlI4xSbdrZlnr4lH2ZStVnZoH+eQObYTtTn4scOVL9ff+7Edhz0I1k/oTkJOY9kGr1N1wmnL/DwVPpjkX4Cl+rTfbReRhuCNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eH5IX/2i; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH5IX/2i"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c27df0daso4672018b3a.1
        for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749546187; x=1750150987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDkZg8wwQgKCEjohuDCo8M/vn8OTWHGeVyS9YUxQ+pE=;
        b=eH5IX/2ibEqdJTMCoI3F/vBAxj1mpFoOPHOYyLyHe4ujyneTjQIX30IWe/Bz9A5Svw
         B7gYN1Dofb+DO/IQ//tkYSKstuxqqNhnuCIBkS1qyWqLV6ls50OuBx+GIF/ozP6BPicl
         1M6CBOVuVQWHZ2DL++o3ksVqUJbWDETHCmXjZh16yHCLmOojuumN17rlpvxKOoSmD7cn
         +xZJhj16C6ZE/W0BjzeVRCIA0gsask4+9esLEMm6KmT7oIuTZekCj9uT7wc2baEuM5W0
         3dPDIZJs6MUoshINizcZXUGyTISF4/XNIwL8c0YUgWiSyH0E/k5ztBDu2uQ86skit9u7
         xT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546187; x=1750150987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDkZg8wwQgKCEjohuDCo8M/vn8OTWHGeVyS9YUxQ+pE=;
        b=pP8NGsDy5Oi7+3oF37VV1kxQd+Xtu/WJASmiaW1J3Si4eG9rjAEvH/PXBqXdNM0qht
         uieVd4nJOUoxsjYgbhqtWUatEJrfKnGsmZOZH4Bj8rovgaiePFlqj2rSTyEkTgpFxNxQ
         4yU2HOGTGayFbxnEwAltfYoO4dxasSWs6+Sri6/YPs2TJ9u6ow3CtXw8UisbT2ho6EIo
         ecdM/h2HLv+lj35fQzYhoP/ZfOf25MU2aRQrJtQtQ6fdBzoaDQ3v/+w3eoF3Hvz/0xq5
         ESwtGXDqdPn/HQPWC8890S3/b9FngAF/Pl9MD4vnfGT2AebHLuPTXknbiEoQyx9VDSwz
         Ut/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZM8LEQJu/0tGuY+QthVujTo0/EkeSAfXFyLv37BXCUIcXcRx/V5mZ9AAmIM48OFa1AgJE0pO3mcwiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydIcnof6XmJi3GQDmkAH/YfVKoJBzkU23MgMPCXjO08Fht7yCf
	lGgN9sZZRFME7Iu2QEfWGcJZGFU1dGMYWRbrrDE/rz81lwzIT5ukH1MDC+KJnJSt27c=
X-Gm-Gg: ASbGncshih/AsYOx8J9LyHRmfEzWK5gQTpW0ND2tdbwd6fntcubZ9uoSZXu7B1DMc3b
	2kgd0DHKmsHYd7briaHaXWkkpqlbKkkm9fINuqi6XNIxmvmazUxR4J72vXHRiXoODnBy97b3ZOr
	ofOHZ3K9Jdwmdt4rad8HTENYoqTQKSCBmIako0wBcedF8E2nu+pmhSpepd2RmalXYvnORLVZmkN
	cGlaMwPh8Qp0uJRI8tJb32Rz+n9A7eWt7xyJXYjjjOcacnrrmIxri9oRBgBRX+JKZvqSxomGGsF
	aAnRsh0vDkof9sb7/OV0NsiTSC8Hzw6jMzFSrmtE1K/4zXvxR0KfP7bjctH2efA=
X-Google-Smtp-Source: AGHT+IEF8ZswbaGt+kAMfjFAaTlcBZCsys6y+j5D6JZRyGaqI7g2gr4LecQHz7V2Fe9yn0I80HERYQ==
X-Received: by 2002:a05:6a00:13a0:b0:748:3964:6177 with SMTP id d2e1a72fcca58-7486188bd4cmr3005131b3a.19.1749546186475;
        Tue, 10 Jun 2025 02:03:06 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c5f73sm6946755b3a.126.2025.06.10.02.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:03:05 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH V2] rust: Use consistent "# Examples" heading style in rustdoc
Date: Tue, 10 Jun 2025 14:33:00 +0530
Message-Id: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a consistent `# Examples` heading in rustdoc across the codebase.

Some modules previously used `## Examples` (even when they should be
available as top-level headers), while others used `# Example`, which
deviates from the preferred `# Examples` style.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Benno Lossin <lossin@kernel.org>
---
V1->V2:
- Don't change the header level for the example in workqueue.rs.
- Update the commit log accordingly.
- Add Ack from Benno.

 rust/kernel/block/mq.rs  |  2 +-
 rust/kernel/clk.rs       |  6 +++---
 rust/kernel/configfs.rs  |  2 +-
 rust/kernel/cpufreq.rs   |  8 ++++----
 rust/kernel/cpumask.rs   |  4 ++--
 rust/kernel/devres.rs    |  4 ++--
 rust/kernel/firmware.rs  |  4 ++--
 rust/kernel/opp.rs       | 16 ++++++++--------
 rust/kernel/pci.rs       |  4 ++--
 rust/kernel/platform.rs  |  2 +-
 rust/kernel/sync.rs      |  2 +-
 rust/kernel/workqueue.rs |  2 +-
 rust/pin-init/src/lib.rs |  2 +-
 13 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index fb0f393c1cea..831445d37181 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -53,7 +53,7 @@
 //! [`GenDiskBuilder`]: gen_disk::GenDiskBuilder
 //! [`GenDiskBuilder::build`]: gen_disk::GenDiskBuilder::build
 //!
-//! # Example
+//! # Examples
 //!
 //! ```rust
 //! use kernel::{
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 6041c6d07527..34a19bc99990 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -12,7 +12,7 @@
 ///
 /// Represents a frequency in hertz, wrapping a [`c_ulong`] value.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// ```
 /// use kernel::clk::Hertz;
@@ -95,7 +95,7 @@ mod common_clk {
     /// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the
     /// allocation remains valid for the lifetime of the [`Clk`].
     ///
-    /// ## Examples
+    /// # Examples
     ///
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
@@ -266,7 +266,7 @@ fn drop(&mut self) {
     /// Instances of this type are reference-counted. Calling [`OptionalClk::get`] ensures that the
     /// allocation remains valid for the lifetime of the [`OptionalClk`].
     ///
-    /// ## Examples
+    /// # Examples
     ///
     /// The following example demonstrates how to obtain and configure an optional clock for a
     /// device. The code functions correctly whether or not the clock is available.
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 34d0bea4f9a5..92cc39a2f7ca 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -17,7 +17,7 @@
 //!
 //! C header: [`include/linux/configfs.h`](srctree/include/linux/configfs.h)
 //!
-//! # Example
+//! # Examples
 //!
 //! ```ignore
 //! use kernel::alloc::flags;
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b0a9c6182aec..944814b1bd60 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -201,7 +201,7 @@ fn from(index: TableIndex) -> Self {
 /// The callers must ensure that the `struct cpufreq_frequency_table` is valid for access and
 /// remains valid for the lifetime of the returned reference.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to read a frequency value from [`Table`].
 ///
@@ -317,7 +317,7 @@ fn deref(&self) -> &Self::Target {
 ///
 /// This is used by the CPU frequency drivers to build a frequency table dynamically.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to create a CPU frequency table.
 ///
@@ -394,7 +394,7 @@ pub fn to_table(mut self) -> Result<TableBox> {
 /// The callers must ensure that the `struct cpufreq_policy` is valid for access and remains valid
 /// for the lifetime of the returned reference.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to create a CPU frequency table.
 ///
@@ -832,7 +832,7 @@ fn register_em(_policy: &mut Policy) {
 
 /// CPU frequency driver Registration.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to register a cpufreq driver.
 ///
diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index c90bfac9346a..0f2dd11d8e6a 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -29,7 +29,7 @@
 /// The callers must ensure that the `struct cpumask` is valid for access and
 /// remains valid for the lifetime of the returned reference.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to update a [`Cpumask`].
 ///
@@ -173,7 +173,7 @@ pub fn copy(&self, dstp: &mut Self) {
 /// The callers must ensure that the `struct cpumask_var_t` is valid for access and remains valid
 /// for the lifetime of [`CpumaskVar`].
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to create and update a [`CpumaskVar`].
 ///
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 0f79a2ec9474..3644c604d4a7 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -42,7 +42,7 @@ struct DevresInner<T> {
 /// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
 /// [`Drop`] implementation.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```no_run
 /// # use kernel::{bindings, c_str, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
@@ -192,7 +192,7 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
     /// An error is returned if `dev` does not match the same [`Device`] this [`Devres`] instance
     /// has been created with.
     ///
-    /// # Example
+    /// # Examples
     ///
     /// ```no_run
     /// # #![cfg(CONFIG_PCI)]
diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 2494c96e105f..e209b5af297c 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -139,7 +139,7 @@ unsafe impl Sync for Firmware {}
 /// Typically, such contracts would be enforced by a trait, however traits do not (yet) support
 /// const functions.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```
 /// # mod module_firmware_test {
@@ -261,7 +261,7 @@ const fn push_internal(mut self, bytes: &[u8]) -> Self {
     /// Append path components to the [`ModInfoBuilder`] instance. Paths need to be separated
     /// with [`ModInfoBuilder::new_entry`].
     ///
-    /// # Example
+    /// # Examples
     ///
     /// ```
     /// use kernel::firmware::ModInfoBuilder;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index a566fc3e7dcb..5f404c4181ad 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -103,7 +103,7 @@ fn to_c_str_array(names: &[CString]) -> Result<KVec<*const u8>> {
 ///
 /// Represents voltage in microvolts, wrapping a [`c_ulong`] value.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// ```
 /// use kernel::opp::MicroVolt;
@@ -128,7 +128,7 @@ fn from(volt: MicroVolt) -> Self {
 ///
 /// Represents power in microwatts, wrapping a [`c_ulong`] value.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// ```
 /// use kernel::opp::MicroWatt;
@@ -153,7 +153,7 @@ fn from(power: MicroWatt) -> Self {
 ///
 /// The associated [`OPP`] is automatically removed when the [`Token`] is dropped.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to create an [`OPP`] dynamically.
 ///
@@ -202,7 +202,7 @@ fn drop(&mut self) {
 /// Rust abstraction for the C `struct dev_pm_opp_data`, used to define operating performance
 /// points (OPPs) dynamically.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to create an [`OPP`] with [`Data`].
 ///
@@ -254,7 +254,7 @@ fn freq(&self) -> Hertz {
 
 /// [`OPP`] search options.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// Defines how to search for an [`OPP`] in a [`Table`] relative to a frequency.
 ///
@@ -326,7 +326,7 @@ fn drop(&mut self) {
 ///
 /// Rust abstraction for the C `struct dev_pm_opp_config`.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to set OPP property-name configuration for a [`Device`].
 ///
@@ -569,7 +569,7 @@ extern "C" fn config_regulators(
 ///
 /// Instances of this type are reference-counted.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to get OPP [`Table`] for a [`Cpumask`] and set its
 /// frequency.
@@ -1011,7 +1011,7 @@ fn drop(&mut self) {
 ///
 /// A reference to the [`OPP`], &[`OPP`], isn't refcounted by the Rust code.
 ///
-/// ## Examples
+/// # Examples
 ///
 /// The following example demonstrates how to get [`OPP`] corresponding to a frequency value and
 /// configure the device with it.
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..2c2ed347c72a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -100,7 +100,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 
 /// Declares a kernel module that exposes a single PCI driver.
 ///
-/// # Example
+/// # Examples
 ///
 ///```ignore
 /// kernel::module_pci_driver! {
@@ -194,7 +194,7 @@ macro_rules! pci_device_table {
 
 /// The PCI driver trait.
 ///
-/// # Example
+/// # Examples
 ///
 ///```
 /// # use kernel::{bindings, device::Core, pci};
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55..f8c0d79445fa 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -120,7 +120,7 @@ macro_rules! module_platform_driver {
 ///
 /// Drivers must implement this trait in order to get a platform driver registered.
 ///
-/// # Example
+/// # Examples
 ///
 ///```
 /// # use kernel::{bindings, c_str, device::Core, of, platform};
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 36a719015583..a38ea4419758 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -39,7 +39,7 @@ impl LockClassKey {
     /// Initializes a dynamically allocated lock class key. In the common case of using a
     /// statically allocated lock class key, the static_lock_class! macro should be used instead.
     ///
-    /// # Example
+    /// # Examples
     /// ```
     /// # use kernel::c_str;
     /// # use kernel::alloc::KBox;
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index d092112d843f..1a8dcd4b4ce1 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -26,7 +26,7 @@
 //!  * The [`WorkItemPointer`] trait is implemented for the pointer type that points at a something
 //!    that implements [`WorkItem`].
 //!
-//! ## Example
+//! ## Examples
 //!
 //! This example defines a struct that holds an integer and can be scheduled on the workqueue. When
 //! the struct is executed, it will print the integer. Since there is only one `work_struct` field,
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 9ab34036e6bc..c5f395b44ec8 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -953,7 +953,7 @@ macro_rules! try_init {
 /// Asserts that a field on a struct using `#[pin_data]` is marked with `#[pin]` ie. that it is
 /// structurally pinned.
 ///
-/// # Example
+/// # Examples
 ///
 /// This will succeed:
 /// ```
-- 
2.31.1.272.g89b43f80a514

