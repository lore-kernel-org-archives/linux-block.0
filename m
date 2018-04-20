Return-Path: <jgross@suse.com>
Subject: Re: [PATCH 2/3] xen netback: add fault injection facility
To: staskins@amazon.com
Cc: jakub.kicinski@netronome.com, hpa@zytor.com, mcroce@redhat.com,
 tglx@linutronix.de, ggarcia@abra.uab.cat, daniel@iogearbox.net,
 x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org,
 axboe@kernel.dk, konrad.wilk@oracle.com, amir.jer.levy@intel.com,
 paul.durrant@citrix.com, stefanha@redhat.com, dsa@cumulusnetworks.com,
 boris.ostrovsky@oracle.com, linux-block@vger.kernel.org,
 wei.liu2@citrix.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dwmw@amazon.co.uk, roger.pau@citrix.com
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104731.17823.97617.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <e33c055c-5a5a-2329-7a2e-faf715bb95fc@suse.com>
 <909fd3b2-19e8-8c13-6ede-cfd6051c6f1d@amazon.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <5c4e4f3d-03ce-b517-d451-3229c0d542c0@suse.com>
Date: Fri, 20 Apr 2018 15:00:28 +0200
MIME-Version: 1.0
In-Reply-To: <909fd3b2-19e8-8c13-6ede-cfd6051c6f1d@amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 20/04/18 14:52, staskins@amazon.com wrote:
> On 04/20/18 13:25, Juergen Gross wrote:
>> On 20/04/18 12:47, Stanislav Kinsburskii wrote:
>>> +    for (fi = 0; fi < XENVIF_FI_MAX; fi++) {
>>> +        vfi->faults[fi] = xen_fi_dir_add(vfi->dir,
>>> +                xenvif_fi_names[fi]);
>> How does this work? xenvif_fi_names[] is an empty array and this is the
>> only reference to it. Who is allocating the memory for that array?
> 
> Well, it works in the way one adds a var to enum (which is used as a key
> later) and a corresponding string into the array (which is used as a
> name for the fault directory in sysfs).

Then you should size the array via XENVIF_FI_MAX.


Juergen
