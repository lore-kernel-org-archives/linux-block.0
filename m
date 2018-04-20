Return-Path: <jgross@suse.com>
Subject: Re: [PATCH 3/3] xen blkback: add fault injection facility
To: Stanislav Kinsburskii <staskins@amazon.com>
Cc: jakub.kicinski@netronome.com, hpa@zytor.com, mcroce@redhat.com,
 tglx@linutronix.de, ggarcia@abra.uab.cat, daniel@iogearbox.net,
 x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org,
 axboe@kernel.dk, konrad.wilk@oracle.com, amir.jer.levy@intel.com,
 paul.durrant@citrix.com, stefanha@redhat.com, dsa@cumulusnetworks.com,
 boris.ostrovsky@oracle.com, linux-block@vger.kernel.org,
 wei.liu2@citrix.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dwmw@amazon.co.uk, roger.pau@citrix.com
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104736.17823.42983.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ef016b7b-6c0e-1684-5714-0a6d5a46504e@suse.com>
Date: Fri, 20 Apr 2018 13:28:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180420104736.17823.42983.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 20/04/18 12:47, Stanislav Kinsburskii wrote:
> This patch adds wrapper helpers around generic Xen fault inject
> facility.
> The major reason is to keep all the module fault injection directories
> in a dedicated subdirectory instead of Xen fault inject root.
> 
> IOW, when using these helpers, per-device and named by device name
> fault injection control directories will appear under the following
> directory:
> - /sys/kernel/debug/xen/fault_inject/xen-blkback/
> instead of:
> - /sys/kernel/debug/xen/fault_inject/
> 
> Signed-off-by: Stanislav Kinsburskii <staskins@amazon.com>
> CC: Jens Axboe <axboe@kernel.dk>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> CC: "Roger Pau Monné" <roger.pau@citrix.com>
> CC: linux-kernel@vger.kernel.org
> CC: linux-block@vger.kernel.org
> CC: xen-devel@lists.xenproject.org
> CC: Stanislav Kinsburskii <staskins@amazon.com>
> CC: David Woodhouse <dwmw@amazon.co.uk>

This is an exact copy of the netback patch apart from the names.

I don't like adding multiple copies of the same coding to the tree.


Juergen
